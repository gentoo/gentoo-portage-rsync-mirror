# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/meteor/meteor-0.5.5.ebuild,v 1.3 2013/02/28 07:51:32 mr_bones_ Exp $

EAPI=5

QA_PRESTRIPPED="opt/meteor/mongodb/bin/mongo
	opt/meteor/mongodb/bin/mongod"

QA_TEXTRELS="opt/meteor/lib/node_modules/fibers/bin/linux-ia32-v8-3.11/fibers.node
	opt/meteor/lib/node_modules/mongodb/node_modules/bson/build/Release/obj.target/bson.node
	opt/meteor/lib/node_modules/mongodb/node_modules/bson/build/Release/bson.node
	opt/meteor/lib/node_modules/websocket/build/Release/xor.node
	opt/meteor/lib/node_modules/websocket/build/Release/obj.target/xor.node
	opt/meteor/lib/node_modules/websocket/build/Release/obj.target/validation.node
	opt/meteor/lib/node_modules/websocket/build/Release/validation.node"

QA_PREBUILT="opt/meteor/bin/node"

QA_FLAGS_IGNORED="opt/meteor/lib/node_modules/fibers/bin/linux-ia32-v8-3.11/fibers.node"

inherit eutils vcs-snapshot

METEOR_BUNDLEV="0.2.18"

DESCRIPTION="An open-source platform for building top-quality web apps in a fraction of the time."
HOMEPAGE="http://meteor.com/"
SRC_URI="https://github.com/meteor/meteor/tarball/v${PV} -> ${P}.tar.gz
	x86? ( https://d3sqy0vbqsdhku.cloudfront.net/dev_bundle_Linux_i686_${METEOR_BUNDLEV}.tar.gz -> ${P}_bundle-${METEOR_BUNDLEV}.tar.gz )
	amd64? ( https://d3sqy0vbqsdhku.cloudfront.net/dev_bundle_Linux_x86_64_${METEOR_BUNDLEV}.tar.gz -> ${P}_bundle-${METEOR_BUNDLEV}.tar.gz )"

LICENSE="AGPL-3
	Apache-2.0
	Boost-1.0
	BSD
	BSD-2
	CC-BY-SA-2.0
	HPND
	MIT
	npm
	ODbL-1.0
	openssl
	public-domain
	Unlicense
	ZLIB || ( BSD-2 GPL-2+ )
	WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_prepare() {
	local DEV_BUNDLE_DIR="${WORKDIR}/${P}_bundle-${METEOR_BUNDLEV}"

	einfo "Moving development bundle ..."
	mv "${DEV_BUNDLE_DIR}"/* "${DEV_BUNDLE_DIR}"/.bundle_version.txt . || die "Couldn't move development bundle."

	einfo "Patching files ..."
	sed -i 's/DEV_BUNDLE=$(dirname "$SCRIPT_DIR")/DEV_BUNDLE="$SCRIPT_DIR"/g' meteor || die "Couldn't patch DEV_BUNDLE script dir."
	sed -i "s/^exports\.CURRENT_VERSION.*/exports.CURRENT_VERSION = \"${PV}-gentoo\";/g" app/lib/updater.js || die "Couldn't add gentoo suffix to version."

	einfo "Removing updater since Portage covers this ..."
	epatch "${FILESDIR}"/${PN}-0.5.4.remove_updater.patch
	rm app/meteor/update.js || die "Couldn't remove updater."

	# We don't care if these fail, just get rid of them if they exist.
	einfo "Removing unnecessary files ..."
	rm -rf admin
	rm -rf {examples,packages}/*/.meteor/local
	rm -rf examples/unfinished
}

src_install() {
	dodir /opt/meteor

	insinto /opt/meteor
	doins -r *
	doins .bundle_version.txt

	dosym /opt/meteor/meteor /usr/bin/meteor

	fperms +x /opt/meteor/meteor
	fperms +x /opt/meteor/bin/node
	fperms +x /opt/meteor/mongodb/bin/mongo
	fperms +x /opt/meteor/mongodb/bin/mongod
}
