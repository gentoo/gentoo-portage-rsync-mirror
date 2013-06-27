# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmikmod/libmikmod-3.2.0-r1.ebuild,v 1.5 2013/06/27 18:39:09 aballier Exp $

EAPI=5
inherit autotools eutils multilib-minimal

DESCRIPTION="A library to play a wide range of module formats"
HOMEPAGE="http://mikmod.shlomifish.org/"
SRC_URI="http://mikmod.shlomifish.org/files/${P}.tar.gz"

LICENSE="LGPL-2+ LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="+alsa altivec coreaudio debug oss static-libs +threads"

REQUIRED_USE="|| ( alsa oss coreaudio )"

RDEPEND="alsa? ( media-libs/alsa-lib:=[${MULTILIB_USEDEP}] )
	!${CATEGORY}/${PN}:2
	abi_x86_32? ( !<=app-emulation/emul-linux-x86-soundlibs-20130224-r3
					!app-emulation/emul-linux-x86-soundlibs[-abi_x86_32(-)] )"
DEPEND="${RDEPEND}
	oss? ( virtual/os-headers )"

ECONF_SOURCE=${S}

src_prepare() {
	EPATCH_SOURCE="${FILESDIR}"/${PV} EPATCH_SUFFIX=patch epatch
	sed -i -e 's:AM_CONFIG_HEADER:AC_CONFIG_HEADERS:' configure.in || die #468212
	eautoreconf
}

multilib_src_configure() {
	econf \
		$(use_enable alsa) \
		$(use_enable altivec) \
		$(use_enable debug) \
		--disable-nas \
		$(use_enable coreaudio osx) \
		$(use_enable oss) \
		$(use_enable static-libs static) \
		$(use_enable threads) \
		--disable-dl
}

multilib_src_install() {
	emake DESTDIR="${D}" install
	dosym ${PN}$(get_libname 3) /usr/$(get_libdir)/${PN}$(get_libname 2)

	local libs="$("${ED}"/usr/bin/libmikmod-config --libs)"
	local privlibs="${libs#*lmikmod}"

	cat <<-EOF > "${T}"/${PN}.pc
	prefix=/usr
	exec_prefix=\${prefix}
	libdir=/usr/$(get_libdir)
	includedir=\${prefix}/include
	Name: ${PN}
	Description: ${DESCRIPTION}
	Version: ${PV}
	Libs: -L${EPREFIX}/usr/$(get_libdir) -lmikmod
	Libs.private: ${privlibs}
	Cflags: -I\${includedir} $("${ED}"/usr/bin/libmikmod-config --cflags)
	EOF

	insinto /usr/$(get_libdir)/pkgconfig
	doins "${T}"/${PN}.pc
}

multilib_src_install_all() {
	dodoc AUTHORS NEWS README TODO
	dohtml docs/*.html
	prune_libtool_files
}
