// const Package = require('../models/Package');


// const addReview = async (req, res) => {
//     try {
//       const { package_id } = req.params;
//       const { rating, text } = req.body;
  
//       const package = await Package.findById(package_id);
//       if (!package) {
//         return res.status(404).send('Package not found');
//       }
  
//       const review = {
//         rating,
//         text,
//         createdAt: new Date(),
//       };
  
//       package.reviews.push(review);
//       await package.save();
  
//       res.status(201).json(review);
//     } catch (error) {
//       res.status(500).send(error.message);
//     }
//   };


//  const editReview = async (req, res) => {
//     try {
//       const { package_id, reviewId } = req.params;
//       const { rating, text } = req.body;
  
//       const package = await Package.findById(package_id);
//       const review = package.reviews.id(reviewId);
  
//       if (!review) {
//         return res.status(404).send('Review not found');
//       }
  
//       review.rating = rating;
//       review.text = text;
  
//       await package.save();
  
//       res.json(review);
//     } catch (error) {
//       res.status(500).send(error.message);
//     }
//   };


//  const deleteReview = async (req, res) => {
//     try {
//       const { package_id, reviewId } = req.params;
  
//       const package = await Package.findById(package_id);
//       const review = package.reviews.id(reviewId);
  
//       if (!review) {
//         return res.status(404).send('Review not found');
//       }
  
//       review.remove();
//       await package.save();
  
//       res.status(204).send();
//     } catch (error) {
//       res.status(500).send(error.message);
//     }
//   };


//  const getAllReviews = async (req, res) => {
//     try {
//       const { package_id } = req.params;
//     print(package_id)
//       const package = await Package.findById(package_id).populate('reviews');
//       if (!package) {
//         return res.status(404).send('Package not found');
//       }
  
//       res.json(package.reviews);
//     } catch (error) {
//       res.status(500).send(error.message);
//     }
//   };

//   // Get a single review by ID
// exports.getReviewById = async (req, res) => {
//     try {
//       const { package_id, reviewId } = req.params;
  
//       const package = await Package.findById(package_id);
//       const review = package.reviews.id(reviewId);
  
//       if (!review) {
//         return res.status(404).send('Review not found');
//       }
  
//       res.json(review);
//     } catch (error) {
//       res.status(500).send(error.message);
//     }
//   };
  

// module.exports = {
//     addReview,
//     editReview,
//     deleteReview,
//     getAllReviews,
//     getReviewById
//   };