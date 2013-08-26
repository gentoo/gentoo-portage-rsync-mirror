# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/tiff/tiff-4.0.3-r4.ebuild,v 1.7 2013/08/26 16:57:13 ago Exp $

EAPI=5
inherit eutils libtool

DESCRIPTION="Tag Image File Format (TIFF) library"
HOMEPAGE="http://www.remotesensing.org/libtiff/"
SRC_URI="http://download.osgeo.org/libtiff/${P}.tar.gz
	ftp://ftp.remotesensing.org/pub/libtiff/${P}.tar.gz"

LICENSE="libtiff"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~m68k ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="+cxx jbig jpeg lzma static-libs zlib"

RDEPEND="jpeg? ( virtual/jpeg:0= )
	jbig? ( media-libs/jbigkit:= )
	lzma? ( app-arch/xz-utils:= )
	zlib? ( sys-libs/zlib:= )"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-4.0.3-tiff2pdf-colors.patch #145055
	epatch "${FILESDIR}"/${P}-CVE-2012-{4447,4564}.patch #440944
	epatch "${FILESDIR}"/${P}-CVE-2013-{1960,1961}.patch #468334
	epatch "${FILESDIR}"/${P}-CVE-2013-{4231,4232}.patch #480466
	epatch "${FILESDIR}"/${P}-libjpeg-turbo.patch

	elibtoolize
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable zlib) \
		$(use_enable jpeg) \
		$(use_enable jbig) \
		$(use_enable lzma) \
		$(use_enable cxx) \
		--without-x \
		--with-docdir="${EPREFIX}"/usr/share/doc/${PF}
}

src_install() {
	default
	prune_libtool_files --all
	rm -f "${ED}"/usr/share/doc/${PF}/{COPYRIGHT,README*,RELEASE-DATE,TODO,VERSION}
}
