# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/meteor/meteor-9999.ebuild,v 1.2 2013/02/08 19:26:04 tomwij Exp $

EAPI=5

inherit eutils git-2

METEOR_BUNDLEV="0.2.17"

DESCRIPTION="An open-source platform for building top-quality web apps in a fraction of the time."
HOMEPAGE="http://meteor.com/"
SRC_URI="x86? ( https://d3sqy0vbqsdhku.cloudfront.net/dev_bundle_Linux_i686_${METEOR_BUNDLEV}.tar.gz -> ${P}_bundle-${METEOR_BUNDLEV}.tar.gz )
	amd64? ( https://d3sqy0vbqsdhku.cloudfront.net/dev_bundle_Linux_x86_64_${METEOR_BUNDLEV}.tar.gz -> ${P}_bundle-${METEOR_BUNDLEV}.tar.gz )"

S="${WORKDIR}"

EGIT_REPO_URI="git://github.com/meteor/meteor.git"
EGIT_BRANCH="devel"
EGIT_SOURCEDIR="${S}"

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
KEYWORDS=""

src_prepare() {
	einfo "Patching files ..."
	sed -i 's/DEV_BUNDLE=$(dirname "$SCRIPT_DIR")/DEV_BUNDLE="$SCRIPT_DIR"/g' meteor || die "Couldn't patch DEV_BUNDLE script dir."
	sed -i 's/^exports\.CURRENT_VERSION.*/exports.CURRENT_VERSION = "devel-gentoo";/g' app/lib/updater.js || die "Couldn't patch version to devel branch."

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
