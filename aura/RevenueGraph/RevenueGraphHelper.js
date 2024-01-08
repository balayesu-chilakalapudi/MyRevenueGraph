({
	createGraph : function(cmp, temp) {
        console.log('temp:'+JSON.stringify(temp));
        //let revenueStreams=[];
        //let revenue_total_value=0;
       /*for(let key in temp){
            revenueStreams.push({key:key,value:temp[key]});
            revenue_total_value+=temp[key];
        }*/
       
      //  cmp.set("v.revenueStreams",revenueStreams);
       // cmp.set("v.revenue_total_value",revenue_total_value);
        
    var dataMap = {"chartLabels": Object.keys(temp),
      "chartData": Object.values(temp)
    };
        console.log('dataMap:'+JSON.stringify(dataMap));
    var el = cmp.find('stackbarChart').getElement();
    var ctx = el.getContext('2d');

    /*new Chart(ctx, {
      type: 'bar',
      data: {
        labels: dataMap.chartLabels,
        datasets: [
          {
              label: "Revenue Graph: Bar Chart",
            backgroundColor: "rgba(153,255,51,0.5)",
            data: dataMap.chartData
          }
        ]
      }
    });*/
        /*
         var chartData = {
            labels: ['Stage 1', 'Stage 2', 'Stage 3', 'Stage 4'], // Add more stages as needed
            datasets: [
                {
                    label: 'Jan',
                    backgroundColor: 'rgba(255, 99, 132, 0.5)',
                    data: [10, 5, 15, 20],
                },
                {
                    label: 'Feb',
                    backgroundColor: 'rgba(54, 162, 235, 0.5)',
                    data: [20, 15, 25, 30],
                },
                // Add more datasets for each month
            ],
        };
                */
        //const labels = Utils.months({count: 7});
        let backgroundColor=[
      'rgb(255, 99, 132)',
      'rgb(54, 162, 235)',
      'rgb(255, 205, 86)',
        'rgb(0, 255, 0)',
          'rgb(57, 55, 10)',
          'rgb(240, 240, 240)',
          'rgb(238, 130, 238)',
          'rgb(255,20,147)',
          'rgb(245,222,179)',
          'rgb(176,196,222)',
          'rgb(127,255,212)',            
          'rgb(189,183,107)'
    ];
        let chartLabels=['Solar Roof','Solar Storage','Commercial','EV Charging','Service Ticket','Detach and Reinstall'];
        let chartDatasets=[];
        let backgroundColorIndex=0;
        for(let key in temp){
            if(key!='Total'){
            chartDatasets.push({
                    label: key,
                    backgroundColor: backgroundColor[backgroundColorIndex++],
                    data: [temp[key].OpportunitiesSolarRoof,temp[key].OpportunitiesSolarStorage,temp[key].OpportunitiesCommercial,temp[key].CasesWithEVCharging,temp[key].CasesServiceTicket,temp[key].CasesDetach]
                });
            }
        }
let data = {
  labels:chartLabels,
  datasets:chartDatasets /*[{
    label: 'Revenue Graph Bar Chart',
    data:dataMap.chartData,    
      backgroundColor: [
      'rgb(255, 99, 132)',
      'rgb(54, 162, 235)',
      'rgb(255, 205, 86)',
        'rgb(0, 255, 0)',
          'rgb(57, 55, 10)',
          'rgb(240, 240, 240)',
          'rgb(238, 130, 238)'
    ],
    borderColor: [
      'rgb(255, 99, 132)',
      'rgb(255, 159, 64)',
      'rgb(255, 205, 86)',
      'rgb(75, 192, 192)',
         'rgb(40, 255, 70)',
         'rgb(80, 55, 20)',
         'rgb(50, 125, 50)'
    ],
    borderWidth: 1
  }]*/
};
        
       let config = {
  type: 'bar',
  data: data,
  options: {
      scales: {
                    xAxes: [{
                        stacked: true,
                    }],
                    yAxes: [{
                        stacked: true,
                    }],
                },
  /*  scales: {
      y: {
        beginAtZero: true,
           ticks:{
              callback:function(value,index){
                  console.log('value:'+this.getLabelForValue(value));
                  if(this.getLabelForValue(value)<=2000000){
                      return 'Jan';
                  }else{
                      return this.getLabelForValue(value);
                  }
              }
      	   }
      }
    }*/
  },
};
        
        
       new Chart(ctx, config); 
  },
  createDoughnutChartGraph : function(cmp, temp) {
      console.log('createDoughnutChartGraph');

    var label = [];
    var firstValue = [];
    var secondValue = [];
      let revenueStreams=[];
      let revenue_total_value=0;
      for(var a=0; a< temp.length; a++){
      console.log(temp[a]["label"]);
      label.push(temp[a]["label"]);
      firstValue.push(temp[a]["firstValue"]);
      secondValue.push(temp[a]["secondValue"]);
          revenueStreams.push({key:temp[a]["label"],value:temp[a]["firstValue"]});
          revenue_total_value+=temp[a]["firstValue"];
    }
      cmp.set("v.revenueStreams",revenueStreams);
      cmp.set("v.revenue_total_value",revenue_total_value);
      let data = {
  labels: label,
  datasets: [{
    label: 'Revenue Graph',
    data: firstValue,
    backgroundColor: [
      'rgb(255, 99, 132)',
      'rgb(54, 162, 235)',
      'rgb(255, 205, 86)',
        'rgb(0, 255, 0)',
        'rgb(57, 55, 10)',
          'rgb(240, 240, 240)',
          'rgb(238, 130, 238)'        
    ],
    hoverOffset: 4
  }]
};
      console.log('data:'+JSON.stringify(data));
    var el = cmp.find('doughnutChart').getElement();
    var ctx = el.getContext('2d');
      
 let config = {
  type: 'doughnut',
  data: data,
};
      
    new Chart(ctx, config);
   
	
    },
  /* doGetChartMap:function(cmp,event,helper,userChoice){
        cmp.set("v.loading",true);
        var temp = [];
        var action = cmp.get("c.getChartMap");
       action.setParams({userChoice:userChoice});
        action.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS' && response.getReturnValue()){
                temp = response.getReturnValue();   
                 let revenueStreams=[];
        let revenue_total_value=0;
       for(let key in temp){
            revenueStreams.push({key:key,value:temp[key]});
            revenue_total_value+=temp[key];
        }
       
        cmp.set("v.revenueStreams",revenueStreams);
        cmp.set("v.revenue_total_value",revenue_total_value.toFixed(2));
               // helper.createGraph(cmp, temp);
            }
            cmp.set("v.loading",false);
        });
         $A.enqueueAction(action);
    },*/
    drawDoughtnutChart:function(cmp,event,helper,userChoice){
        try{
        cmp.set("v.loading",true);
         var temp2 = [];
        var action1 = cmp.get("c.getLineChartMap");
        action1.setParams({userChoice:userChoice});
        action1.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS' && response.getReturnValue()){
                temp2 = JSON.parse(response.getReturnValue());
                
                try{
                helper.createDoughnutChartGraph(cmp, temp2);
                }catch(err){
                    console.log(err.stack);
                }
            }
            cmp.set("v.loading",false);
        });
       
        $A.enqueueAction(action1);
        }catch(err){
            console.log(err.stack);
        }
    },
    dogetCasesServiceTicket:function(cmp,event,helper,userChoice){
        //cmp.set("v.loading",true);
         var temp2 = [];
        var action1 = cmp.get("c.getCasesServiceTicket");
        action1.setParams({userChoice:userChoice});
        action1.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS' && response.getReturnValue()){
                temp2 = response.getReturnValue();    
                
                cmp.set("v.CasesServiceTicket",temp2);
                console.log('temp2:'+JSON.stringify(temp2));
            }
            //cmp.set("v.loading",false);
        });
       
        $A.enqueueAction(action1);
    },
    dogetCasesEVCharging:function(cmp,event,helper,userChoice){
        //cmp.set("v.loading",true);
         var temp2 = [];
        var action1 = cmp.get("c.getCasesEVCharging");
        action1.setParams({userChoice:userChoice});
        action1.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS' && response.getReturnValue()){
                temp2 = response.getReturnValue();    
                
                cmp.set("v.CasesEVCharging",temp2);
                console.log('temp2:'+JSON.stringify(temp2));
            }
            //cmp.set("v.loading",false);
        });
       
        $A.enqueueAction(action1);
    },
    dogetCasesDetachReinstall:function(cmp,event,helper,userChoice){
        //cmp.set("v.loading",true);
         var temp2 = [];
        var action1 = cmp.get("c.getCasesDetachReinstall");
        action1.setParams({userChoice:userChoice});
        action1.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS' && response.getReturnValue()){
                temp2 = response.getReturnValue();    
                
                cmp.set("v.CasesDetachAndReinstall",temp2);
                console.log('temp2:'+JSON.stringify(temp2));
            }
            //cmp.set("v.loading",false);
        });
       
        $A.enqueueAction(action1);
    },
    dogetOpportunities:function(cmp,event,helper,userChoice){
        //cmp.set("v.loading",true);
         var temp2 = [];
        var action1 = cmp.get("c.getOpportunities");
        action1.setParams({userChoice:userChoice});
        action1.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS' && response.getReturnValue()){
                temp2 = response.getReturnValue();    
                
                cmp.set("v.Opportunities",temp2);
                console.log('temp2:'+JSON.stringify(temp2));
            }
            //cmp.set("v.loading",false);
        });
       
        $A.enqueueAction(action1);
    },
    dogetCaseWrapMap:function(cmp,event,helper,userChoice){
        cmp.set("v.twelvemonthsofdataLoading",true);
        cmp.set("v.loading",true);
         var temp2 = [];
        var action1 = cmp.get("c.getCaseWrapMap");
        action1.setParams({userChoice:userChoice});
        action1.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS' && response.getReturnValue()){
                temp2 = response.getReturnValue(); 
                helper.createGraph(cmp, temp2);
                let cwlist=[];
                let CaseWrapList=[];
                let revenueStreams=[];
                let revenue_total_value=0;
        for(let key in temp2){
            CaseWrapList.push({key:key,value:temp2[key]});
            if(key=='Total'){
                console.log('key:'+key);
                revenueStreams.push({key:'Solar Roof',value:temp2[key].OpportunitiesSolarRoof});
                revenue_total_value+=temp2[key].OpportunitiesSolarRoof;
                
                revenueStreams.push({key:'Solar Storage',value:temp2[key].OpportunitiesSolarStorage});
                revenue_total_value+=temp2[key].OpportunitiesSolarStorage;
                
                revenueStreams.push({key:'Commercial',value:temp2[key].OpportunitiesCommercial});
                revenue_total_value+=temp2[key].OpportunitiesCommercial;
                
                revenueStreams.push({key:'EV Charging',value:temp2[key].CasesWithEVCharging});
                revenue_total_value+=temp2[key].CasesWithEVCharging;
                
                revenueStreams.push({key:'Service Ticket',value:temp2[key].CasesServiceTicket});
                revenue_total_value+=temp2[key].CasesServiceTicket;
                
                revenueStreams.push({key:'Detach And Reinstall',value:temp2[key].CasesDetach});
                revenue_total_value+=temp2[key].CasesDetach;
            }
        }
        cmp.set("v.CaseWrapList",CaseWrapList);  
        cmp.set("v.revenueStreams",revenueStreams);
        cmp.set("v.revenue_total_value",revenue_total_value.toFixed(2));
         
            }
            cmp.set("v.twelvemonthsofdataLoading",false);
            cmp.set("v.loading",false);
        });
       
        $A.enqueueAction(action1);
    },
})