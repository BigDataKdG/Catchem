//	Geef een overzicht van alle metingen gerangschikt per treasure en daarbinnen per quest.

db.catchemAll.find({}).sort({stage_id: 1}).sort({quest_id: 1})

//	Geef per quest de gemiddelde hartslag weer.

db.catchemAll.aggregate([
{$group: {
    average: {$avg: "$heart_rate"},
    _id: "$quest_id"}}])
    
// Geef een overzicht van alle metingen voor quests bij een gemiddelde hoogte per quest hoger dan 300 meter uitgevoerd zijn.

// Neem één centraal punt en geef dan een overzicht van alle GPS-coördinaten die gemeten zijn in een straal van 100 km (dit mag met flat of spherical 2D gedaan worden)

// eerst lat en long omzetten naar 1 field omdat 2d niet werkt met lat en long als aparte fields
db.catchemAll.find().forEach(function (e) {
    e.geo = {
	type: "Point",
        coordinates: [e.long, e.lat] // Longitude goes first, Latitude range: [-90..90]
    };
    db.catchemAll.save(e);
});

// db.catchemAll.update({}, {$unset: {lat:1, long:1}}, false, true)

db.catchemAll.createIndex( { geo : "2dsphere" } )

db.catchemAll.find(
{
     geo:
       { $near :
          {
            $geo: { type: "Point",  coordinates: [  112.35518, 28.55386 ] },
            $minDistance: 0,
            $maxDistance: 100000
          }
       }
   }
)

