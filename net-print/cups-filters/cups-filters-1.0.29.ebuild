# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cups-filters/cups-filters-1.0.29.ebuild,v 1.2 2013/02/06 12:57:25 gienah Exp $

EAPI=4

GENTOO_DEPEND_ON_PERL=no

inherit base perl-module autotools

if [[ "${PV}" == "9999" ]] ; then
	inherit autotools bzr
	EBZR_REPO_URI="http://bzr.linuxfoundation.org/openprinting/cups-filters"
	KEYWORDS=""
else
	SRC_URI="http://www.openprinting.org/download/${PN}/${P}.tar.xz"
	KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd"
fi
DESCRIPTION="Cups PDF filters"
HOMEPAGE="http://www.linuxfoundation.org/collaborate/workgroups/openprinting/pdfasstandardprintjobformat"

LICENSE="MIT GPL-2"
SLOT="0"
IUSE="avahi jpeg perl png static-libs tiff"

RDEPEND="
	app-text/ghostscript-gpl
	app-text/poppler[cxx,jpeg?,lcms,tiff?,xpdf-headers(+)]
	>=app-text/qpdf-3.0.2
	media-libs/fontconfig
	media-libs/freetype:2
	media-libs/lcms:2
	>net-print/cups-1.5.9999
	!<=net-print/cups-1.5.9999
	sys-devel/bc
	sys-libs/zlib
	avahi? ( net-dns/avahi )
	jpeg? ( virtual/jpeg )
	perl? ( dev-lang/perl )
	png? ( media-libs/libpng )
	tiff? ( media-libs/tiff )
"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${PN}-1.0.29-openrc.patch"
	"${FILESDIR}/${PN}-1.0.29-poppler-0.22.patch")

src_prepare() {
	base_src_prepare
	if [[ "${PV}" == "9999" ]]; then
		eautoreconf
	else
		eautoreconf
	fi
}

src_configure() {
	econf \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		$(use_enable avahi) \
		$(use_enable static-libs static) \
		--with-fontdir="fonts/conf.avail" \
		--with-pdftops=pdftops \
		--enable-imagefilters \
		$(use_with jpeg) \
		$(use_with png) \
		$(use_with tiff) \
		--without-php
}

src_compile() {
	default

	if use perl; then
		pushd "${S}/scripting/perl" > /dev/null
		perl-module_src_prep
		perl-module_src_compile
		popd > /dev/null
	fi
}

src_install() {
	default

	if use perl; then
		pushd "${S}/scripting/perl" > /dev/null
		perl-module_src_install
		fixlocalpod
		popd > /dev/null
	fi

	find "${ED}" -name '*.la' -exec rm -f {} +

	if use avahi; then
		newinitd "${FILESDIR}"/cups-browsed.init.d cups-browsed
	fi;
}

pkg_postinst() {
	perl-module_pkg_postinst

	if use avahi; then
		elog "This version of cups-filters includes cups-browsed, a daemon that autodiscovers"
		elog "remote queues via avahi and adds them to your cups configuration. You may want"
		elog "to add it to your default runlevel. Then again, you may not want to do that,"
		elog "since it is completely untested, may kill kittens or get you r00ted. Your choice."
	fi
}
