const upload = require("../middleware/s3.upload")

const uploadFile = async (req, res) => {
    upload(req, res, async function(err) {
        if (err) {
            return res.status(400).send({
                result: 0,
                message: err,
            });
        }
        return res.status(200).send({
            result: 1,
            message: "uploaded succeessfully"
        });
    })
};

module.exports = {
    uploadFile
};