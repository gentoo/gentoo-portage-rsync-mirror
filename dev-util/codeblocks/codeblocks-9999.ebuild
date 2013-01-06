# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/codeblocks/codeblocks-9999.ebuild,v 1.4 2012/11/02 06:03:31 dirtyepic Exp $

EAPI="4"
WX_GTK_VER="2.8"

inherit autotools eutils flag-o-matic subversion wxwidgets

DESCRIPTION="The open source, cross platform, free C++ IDE."
HOMEPAGE="http://www.codeblocks.org/"
ESVN_REPO_URI="svn://svn.berlios.de/${PN}/trunk"
SRC_URI=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="contrib debug pch static-libs"

RDEPEND="x11-libs/wxGTK:2.8[X]"
DEPEND="${RDEPEND}
	app-arch/zip
	dev-libs/libgamin
	sys-devel/libtool:2
	virtual/pkgconfig"

src_unpack(){
	subversion_src_unpack
}

src_prepare() {
	# Let's make the autorevision work.
	subversion_wc_info
	CB_LCD=$(LC_ALL=C svn info "${ESVN_WC_PATH}" | grep "^Last Changed Date:" | cut -d" " -f4,5)
	echo "m4_define([SVN_REV], ${ESVN_WC_REVISION})" > revision.m4
	echo "m4_define([SVN_DATE], ${CB_LCD})" >> revision.m4
	eautoreconf
}

src_configure() {
	# C::B is picky on CXXFLAG -fomit-frame-pointer
	# (project-wizard crash, instability ...)
	filter-flags -fomit-frame-pointer
	append-flags -fno-strict-aliasing

	econf \
		--with-wx-config="${WX_CONFIG}" \
		$(use_enable debug) \
		$(use_enable pch) \
		$(use_enable static-libs static) \
		$(use_with contrib contrib-plugins all)
}

src_compile() {
	emake clean-zipfiles
	emake
}

src_install() {
	default
	prune_libtool_files
}
