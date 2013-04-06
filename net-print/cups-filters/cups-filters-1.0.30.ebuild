# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cups-filters/cups-filters-1.0.30.ebuild,v 1.3 2013/04/06 10:20:47 dilfridge Exp $

EAPI=5

GENTOO_DEPEND_ON_PERL=no

inherit base eutils perl-module autotools

if [[ "${PV}" == "9999" ]] ; then
	inherit bzr
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
IUSE="jpeg perl png static-libs tiff zeroconf"

RDEPEND="
	app-text/ghostscript-gpl
	app-text/poppler:=[cxx,jpeg?,lcms,tiff?,xpdf-headers(+)]
	>=app-text/qpdf-3.0.2
	media-libs/fontconfig
	media-libs/freetype:2
	media-libs/lcms:2
	>net-print/cups-1.5.9999
	!<=net-print/cups-1.5.9999
	sys-devel/bc
	sys-libs/zlib
	jpeg? ( virtual/jpeg )
	perl? ( dev-lang/perl )
	png? ( media-libs/libpng:0= )
	tiff? ( media-libs/tiff )
	zeroconf? ( net-dns/avahi )
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-1.0.29-openrc.patch"
	"${FILESDIR}/${PN}-1.0.30-noavahi.patch"
)

src_prepare() {
	base_src_prepare
	eautoreconf
}

src_configure() {
	econf \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		$(use_enable zeroconf avahi) \
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

	prune_libtool_files --all

	use zeroconf && newinitd "${FILESDIR}"/cups-browsed.init.d cups-browsed
}

pkg_postinst() {
	perl-module_pkg_postinst

	if use zeroconf; then
		elog "This version of cups-filters includes cups-browsed, a daemon that autodiscovers"
		elog "remote queues via avahi and adds them to your cups configuration. You may want"
		elog "to add it to your default runlevel. Not much tested so far, though."
	fi
}
