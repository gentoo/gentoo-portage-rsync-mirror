# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/magick-rotation/magick-rotation-1.6.2.ebuild,v 1.3 2013/01/24 09:07:22 pinkbyte Exp $

EAPI=4

PYTHON_DEPEND="2"

inherit eutils python toolchain-funcs user versionator

MY_PV=$(get_version_component_range 1-2)

DESCRIPTION="application that rotate tablet pc's screen automatically, depending on orientation"
HOMEPAGE="https://launchpad.net/magick-rotation"
SRC_URI="http://launchpad.net/magick-rotation/trunk/${MY_PV}/+download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/libXrandr
	x11-libs/libX11"

RDEPEND="${DEPEND}
	dev-python/pygobject
	dev-python/py-notify
	x11-apps/xinput"

# there are not tests in package, default 'make check' does wrong things, bug #453672
RESTRICT="test"

pkg_setup() {
	python_pkg_setup
	enewgroup magick
}

src_prepare() {
	# Remove unneeded files
	rm -r apt_* installer_gtk.py MAGICK-INSTALL gset_addkeyval.py MagickIcons/MagickSplash.png MagickUninstall || die 'removing unneeded files failed'
}

src_compile() {
	local suffix=
	if use amd64; then
		suffix=64
	else
		suffix=32
	fi
	tc-export_build_env
	echo "$(tc-getCC) $CFLAGS $LDFLAGS check.c -lX11 -lXrandr -o checkmagick${suffix}"
	$(tc-getCC) $CFLAGS $LDFLAGS check.c -lX11 -lXrandr -o "checkmagick${suffix}" || die 'compilation failed'
}

src_install() {
	#TODO: add installation of GNOME Shell 3.2 extension
	dobin	checkmagick*

	insinto	/lib/udev/rules.d
	doins	62-magick.rules

	insinto	/usr/share/${PN}
	doins	*.py

	insinto	/usr/share/${PN}/MagickIcons
	doins	MagickIcons/*.png

	exeinto /usr/share/${PN}
	doexe	magick-rotation
	doexe	xrotate.py

	dodoc *.txt ChangeLog

	make_desktop_entry /usr/share/${PN}/${PN} "Magick Rotation" /usr/share/${PN}/MagickIcons/magick-rotation-enabled.png "System;Utility;"
}

pkg_postinst() {
	optfeature() {
		elog "  [\e[1m$(has_version ${1} && echo I || echo ' ')\e[0m] ${1} (${2})"
	}

	python_mod_optimize /usr/share/${PN}

	elog
	elog "In order to use Magick Rotation with an on-screen keyboard and handwriting,"
	elog "the following additional package may also be installed for use at run-time:"
	elog
	optfeature 'media-gfx/cellwriter' "Magick Rotation's default onscreen keyboard"
	elog

	ewarn "in order to use Magick Rotation you have to be in the 'magick' group."
	ewarn "Just run 'gpasswd -a <USER> magick', then have <USER> re-login."
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}
}
