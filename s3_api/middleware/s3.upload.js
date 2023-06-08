const multer = require("multer");
const multerS3 = require("multer-s3-transform");
const AWS = require("aws-sdk");
const config = require("../config/s3.config")

const S3 = new AWS.S3({
    accessKeyID: config.AWS_ACCESS_KEY_ID,
    secretAccessKey: config.AWS_SECRET_ACCESS_KEY
});

const upload = multer({
    storage: multerS3({
        s3: S3,
        bucket: config.AWS_BUCKET_NAME,
        acl: 'public-read',
        key: function(req, file, callback) {
            if (file.fieldname == "singlefile") {
                callback(null, "single/" + file.originalname);
            } else if (file.fieldname == "multiplefiles") {
                callback(null, "multiple/" + file.originalname);
            }
        }
    })
});

module.exports = upload.fields([
    {
        name: 'singlefile', maxCount: 1
    }, {
        name: 'multiplefiles', maxCount: 5
    }
])