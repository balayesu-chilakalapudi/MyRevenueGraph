({
	dogetCaseWrapMap:function(cmp,event,helper,userChoice){
        cmp.set("v.loading",true);
         var temp2 = [];
        var action1 = cmp.get("c.getDataWrapperMap");
        action1.setParams({userChoice:userChoice});
        action1.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS' && response.getReturnValue()){
                temp2 = response.getReturnValue(); 
                helper.createGraph(cmp, temp2);
                let revenueStreams=[];
        for(let key in temp2){
            revenueStreams.push({key:key,value:temp2[key]});
        }
        cmp.set("v.CaseWrapList",revenueStreams);
            }
            cmp.set("v.loading",false);
        });
       
        $A.enqueueAction(action1);
    },
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
       
   
        
        try{
            // cmp.find('stackBarChart').getElement().remove();
            console.log('removing element');   
            document.getElementById('stackBarChart').remove();
            console.log('done');
         let canvasElement=document.createElement('canvas');
            canvasElement.id='stackBarChart';
           // document.body.appendChild(canvasElement);        
       document.getElementById('barDiv').appendChild(canvasElement);        
        }catch(err){
            console.log(err.stack);
        }
        
        var el= document.getElementById('stackBarChart');
            //cmp.find('stackBarChart').getElement();        
    	var ctx= el.getContext('2d');
   
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
        let chartLabels=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
        let chartDatasets=[];
        let backgroundColorIndex=0;      
           
        
            chartDatasets.push({
                    label: 'Leads',
                    backgroundColor: 'rgb('+Math.floor(Math.random() * 255)+','+Math.floor(Math.random() * 255)+','+Math.floor(Math.random() * 255)+')',
                    data: [temp['Jan'].Leads,temp['Feb'].Leads,temp['Mar'].Leads,temp['Apr'].Leads,temp['May'].Leads,temp['Jun'].Leads,
                          temp['Jul'].Leads,temp['Aug'].Leads,temp['Sep'].Leads,temp['Oct'].Leads,temp['Nov'].Leads,temp['Dec'].Leads
                          ]                
                },
                              {
                    label: 'Contacts',
                    backgroundColor: 'rgb('+Math.floor(Math.random() * 255)+','+Math.floor(Math.random() * 255)+','+Math.floor(Math.random() * 255)+')',
                    data: [temp['Jan'].Contacts,temp['Feb'].Contacts,temp['Mar'].Contacts,temp['Apr'].Contacts,temp['May'].Contacts,temp['Jun'].Contacts,
                          temp['Jul'].Contacts,temp['Aug'].Contacts,temp['Sep'].Contacts,temp['Oct'].Contacts,temp['Nov'].Contacts,temp['Dec'].Contacts
                          ]
                });
            
        
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
})