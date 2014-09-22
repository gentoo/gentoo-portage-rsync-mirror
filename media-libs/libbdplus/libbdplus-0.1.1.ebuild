# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libbdplus/libbdplus-0.1.1.ebuild,v 1.1 2014/09/22 21:35:45 beandog Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_PRUNE_LIBTOOL_FILES=all
SCM=""

if [ "${PV#9999}" != "${PV}" ] ; then
	SCM="git-r3"
	EGIT_REPO_URI="git://git.videolan.org/${PN}.git"
	SRC_URI=""
else
	SRC_URI="http://ftp.videolan.org/pub/videolan/${PN}/${PV}/${P}.tar.bz2"
fi

DESCRIPTION="Blu-ray library for BD+ decryption"
HOMEPAGE="http://www.videolan.org/developers/libbdplus.html"
IUSE="aacs"

inherit autotools-multilib ${SCM}

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-libs/libgcrypt
	aacs? ( >=media-libs/libaacs-0.7.0 )"
DEPEND="${RDEPEND}"

DOCS="ChangeLog README.txt"

multilib_src_configure() {
	ECONF_SOURCE="${S}" econf \
		--disable-optimizations \
		$(use_with aacs libaacs)
}
