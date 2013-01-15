# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tdom/tdom-0.8.3-r2.ebuild,v 1.1 2013/01/15 14:21:40 jlec Exp $

EAPI=5

inherit autotools eutils multilib

MY_P="tDOM-${PV}"

DESCRIPTION="A XML/DOM/XPath/XSLT Implementation for Tcl"
HOMEPAGE="http://tdom.github.com/"
#SRC_URI="http://cloud.github.com/downloads/tDOM/${PN}/${MY_P}.tgz"
SRC_URI="mirror://github/tDOM/${PN}/${MY_P}.tgz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="static-libs threads"

DEPEND="
	dev-lang/tcl:=
	dev-libs/expat"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${FILESDIR}/"${PN}-0.8.2.patch
	"${FILESDIR}/"${P}-soname.patch
	"${FILESDIR}/"${P}-expat.patch
	"${FILESDIR}/"${PN}-0.8.2-tnc.patch
	"${FILESDIR}/"${P}-tcl8.6.patch
	)

src_prepare() {
	sed \
		-e 's:-O2::g' \
		-e 's:-pipe::g' \
		-e 's:-fomit-frame-pointer::g' \
		-i {.,extensions/tnc}/configure tclconfig/tcl.m4 || die
	epatch "${PATCHES[@]}"
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		$(use_enable threads)
		--enable-shared
		--disable-tdomalloc
		--with-expat
		)

	cd "${S}"/unix && ECONF_SOURCE=".." econf ${myeconfargs}
	cd "${S}"/extensions/tdomhtml &&	econf ${myeconfargs}
	cd "${S}"/extensions/tnc && econf ${myeconfargs}
}

src_compile() {
	local dir

	for dir in "${S}"/unix "${S}"/extensions/tnc; do
		pushd ${dir} > /dev/null
			emake
		popd > /dev/null
	done
}

src_install() {
	local dir

	dodoc CHANGES ChangeLog README*

	for dir in "${S}"/unix "${S}"/extensions/tdomhtml "${S}"/extensions/tnc; do
		pushd ${dir} > /dev/null
			emake DESTDIR="${D}" install
		popd > /dev/null
	done

	if ! use static-libs; then
		einfo "Removing static libs ..."
		rm -f "${ED}"/usr/$(get_libdir)/*.{a,la} || die
	fi
}
