//
//  PhotoListTableViewCell.swift
//  PhotoGalleryAppAsignment
//
//  Created by Muhhmmd Jawed Ansari on 28/02/26.
//

import UIKit

class PhotoListTableViewCell: UITableViewCell {

    static let identifier = "PhotoCell"
    private let containerView = UIView()
    private let photoImageView = UIImageView()
    private let titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = true

        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.numberOfLines = 0

        contentView.addSubview(containerView)
        containerView.addSubview(photoImageView)
        containerView.addSubview(titleLabel)
        
        photoImageView.layer.cornerRadius = 30
        photoImageView.layer.borderWidth = 1
        photoImageView.layer.borderColor = UIColor.black.cgColor
        photoImageView.layer.masksToBounds = true

        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            containerView.heightAnchor.constraint(equalToConstant: 70),

            photoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            photoImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: 60),
            photoImageView.heightAnchor.constraint(equalToConstant: 60),

            titleLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }

    func configure(photo: PhotoEntity) {
        titleLabel.text = photo.title
        photoImageView.loadImage(url: photo.thumbnailUrl ?? "")
        //photoImageView.loadImage(url: "https://picsum.photos/id/237/200/200")
        
    }
}
