# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/picasa/picasa-3.0.0.57.4402.0_beta.ebuild,v 1.8 2012/06/08 02:57:49 zmedico Exp $

# needs SRC_URI arrows
EAPI=2

inherit eutils multilib versionator rpm nsplugins

MY_P="${PN}-$(get_version_component_range 1-2)"
DESCRIPTION="Google's photo organizer"
HOMEPAGE="http://picasa.google.com"
SRC_URI="http://dl.google.com/linux/rpm/testing/i386/${MY_P}-current.i386.rpm
	-> ${P}.i386.rpm"
LICENSE="google-picasa"
SLOT="0"
KEYWORDS="-* amd64 x86"
RESTRICT="mirror strip"
IUSE="nsplugin"

RDEPEND="x86? (
		dev-libs/atk
		dev-libs/glib:2
		dev-libs/libxml2:2
		sys-libs/zlib
		x11-libs/gtk+:2
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libXt
		x11-libs/pango )
	amd64? (
		app-emulation/emul-linux-x86-gtklibs
	)
	nsplugin? ( >=www-client/firefox-3.0.0 )
	"
DEPEND=""

QA_TEXTRELS="opt/google/picasa/3.0/wine/lib/wine/set_lang.exe.so
	opt/google/picasa/3.0/wine/lib/wine/browser_prompt.exe.so
	opt/google/picasa/3.0/wine/lib/wine/check_dir.exe.so
	opt/google/picasa/3.0/wine/lib/wine/license.exe.so"

S="${WORKDIR}"

src_unpack() {
	rpm_src_unpack ${A}
}

src_install() {
	local target="opt/google/picasa/3.0"
	cd ${target}
	dodir /${target}
	mv bin $(get_libdir) wine "${D}/${target}" || die

	# bug #298496
	rm -rfv "${D}/${target}/wine/lib/wine/wineesd.drv.so" || die

	dodir /usr/bin
	for i in picasa picasafontcfg showpicasascreensaver; do
		dosym /${target}/bin/${i} /usr/bin/${i}
	done

	dodir /${target}/desktop
	mv desktop/picasa32x32.xpm "${D}/${target}/desktop/" || die

	dodoc README LICENSE.FOSS || die

	cd desktop || die

	sed -e "s:EXEC:picasa:" -e "s:ICON:picasa.xpm:" \
		picasa.desktop.template > picasa.desktop || die
	echo "Categories=Graphics;" >> picasa.desktop

	sed -e "s:EXEC:picasafontcfg:" -e "s:ICON:picasa-fontcfg.xpm:" \
		picasa-fontcfg.desktop.template > picasa-fontcfg.desktop || die
	echo "Categories=Graphics;" >> picasa-fontcfg.desktop

	doicon picasa{,-fontcfg}.xpm || die
	domenu {picasa{,-fontcfg,-kdehal},picasascr}.desktop || die

	use nsplugin && inst_plugin /${target}/$(get_libdir)/npPicasa3.so
}
