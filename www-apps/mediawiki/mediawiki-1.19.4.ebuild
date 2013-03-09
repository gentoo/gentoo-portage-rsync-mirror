# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mediawiki/mediawiki-1.19.4.ebuild,v 1.4 2013/03/09 11:29:52 ago Exp $

EAPI=5
inherit webapp versionator

MY_BRANCH=$(get_version_component_range 1-2)

DESCRIPTION="The MediaWiki wiki web application (as used on wikipedia.org)"
HOMEPAGE="http://www.mediawiki.org"
SRC_URI="http://download.wikimedia.org/mediawiki/${MY_BRANCH}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ppc x86"
IUSE="imagemagick mysql postgres sqlite"

RDEPEND=">=dev-lang/php-5.3[mysql?,postgres?,session,xml,xmlreader]
	imagemagick? ( || ( media-gfx/imagemagick media-gfx/graphicsmagick[imagemagick] ) )
	!imagemagick? ( dev-lang/php[gd] )
	sqlite? (
		dev-db/sqlite:3[fts3]
		>=dev-lang/php-5.3[pdo]
		|| ( dev-lang/php[sqlite] dev-lang/php[sqlite3] )
	)
	virtual/httpd-php"

need_httpd_cgi

RESTRICT="test"

src_install() {
	webapp_src_preinst

	# First we install docs and then copy everything left into htdocs dir
	# to avoid bugs like #236411.

	# We ensure the directories are prepared for writing.  The post-
	# install instructions guide the user to enable the feature.
	local DOCS="FAQ HISTORY INSTALL README RELEASE-NOTES-${PV:0:4} UPGRADE"
	dodoc ${DOCS} docs/*.txt
	docinto php-memcached
	dodoc docs/php-memcached/*

	# Clean everything not used at the site...
	rm -rf ${DOCS} COPYING tests docs
	find . -name Makefile -delete
	# and install
	insinto "${MY_HTDOCSDIR}"
	doins -r .

	# If imagemagick is enabled then setup for image upload.
	# We ensure the directory is prepared for writing.
	if use imagemagick ; then
		webapp_serverowned "${MY_HTDOCSDIR}"/images
	fi

	webapp_postinst_txt en "${FILESDIR}/postinstall-1.18-en.txt"
	webapp_postupgrade_txt en "${FILESDIR}/postupgrade-1.16-en.txt"
	webapp_src_install
}

pkg_preinst() {
	prev_install="false"
	if has_version ${CATEGORY}/${PN} ; then
		prev_install="true"
	fi
}

pkg_postinst() {
	webapp_pkg_postinst

	if ${prev_install} ; then
		einfo
		elog "=== Consult the release notes ==="
		elog "Before doing anything, stop and consult the release notes"
		elog "/usr/share/doc/${PF}/RELEASE-NOTES-${PV:0:4}.bz2"
		elog
		elog "These detail bug fixes, new features and functionality, and any"
		elog "particular points that may need to be noted during the upgrade procedure."
		einfo
		ewarn "Back up existing files and the database before upgrade."
		ewarn "http://www.mediawiki.org/wiki/Manual:Backing_up_a_wiki"
		ewarn "provides an overview of the backup process."
		einfo
	fi
}
