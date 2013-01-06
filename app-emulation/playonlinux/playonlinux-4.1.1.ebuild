# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/playonlinux/playonlinux-4.1.1.ebuild,v 1.1 2012/06/16 19:12:24 pacho Exp $

EAPI="4"
PYTHON_DEPEND="2"

inherit eutils python games

MY_PN="PlayOnLinux"

DESCRIPTION="Set of scripts to easily install and use Windows games and software"
HOMEPAGE="http://playonlinux.com/"
SRC_URI="http://www.playonlinux.com/script_files/${MY_PN}/${PV}/${MY_PN}_${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="winbind"

DEPEND=""
RDEPEND="app-emulation/wine
	app-arch/cabextract
	app-arch/p7zip
	app-arch/unzip
	app-crypt/gnupg
	dev-python/wxpython:2.8
	|| ( media-gfx/imagemagick media-gfx/graphicsmagick[imagemagick] )
	net-misc/wget
	x11-apps/mesa-progs
	x11-terms/xterm
	media-gfx/icoutils
	winbind? ( net-fs/samba[winbind] ) "

S=${WORKDIR}/${PN}

# TODO:
# Having a real install script and let playonlinux use standard filesystem
# 	architecture to prevent having everything installed into GAMES_DATADIR
# It will let using LANGUAGES easily
# How to deal with Microsoft Fonts installation asked every time ?
# How to deal with wine version installed ? (have a better mgmt of system one)
# Look at debian pkg: http://packages.debian.org/sid/playonlinux

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
	games_pkg_setup
}

src_prepare() {
	sed -i -e "s/\(Categories=\).*/\1Game;Emulator;/" etc/PlayOnLinux.desktop \
		|| die
	sed -e 's/PYTHON="python"/PYTHON="python2"/' -i lib/variables playonlinux || die
	python_convert_shebangs -r 2 .
}

src_install() {
	# all things without exec permissions
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r resources lang lib etc plugins

	# bash/ install
	exeinto "${GAMES_DATADIR}/${PN}/bash"
	doexe bash/*
	exeinto "${GAMES_DATADIR}/${PN}/bash/terminals"
	doexe bash/terminals/*
	exeinto "${GAMES_DATADIR}/${PN}/bash/expert"
	doexe bash/expert/*

	# python/ install
	exeinto "${GAMES_DATADIR}/${PN}/python"
	doexe python/*
	# sub dir without exec permissions
	insinto "${GAMES_DATADIR}/${PN}/python"
	doins -r python/lib

	# main executable files
	exeinto "${GAMES_DATADIR}/${PN}"
	doexe ${PN}{,-pkg,-bash,-shell,-url_handler}

	# making a script to run playonlinux from ${GAMES_BINDIR}
	echo "#!/bin/bash" > ${PN}_launcher
	echo "cd \"${GAMES_DATADIR}/${PN}\" && ./${PN} \$*" >> ${PN}_launcher
	newgamesbin playonlinux_launcher playonlinux

	# making a script to run playonlinux-cmd from ${GAMES_BINDIR}
	echo "#!/bin/bash" > ${PN}_cmd_launcher
	echo "cd \"${GAMES_DATADIR}/${PN}\" && ./${PN}-cmd \$*" >> ${PN}_cmd_launcher
	newgamesbin playonlinux_cmd_launcher playonlinux-cmd

	dodoc CHANGELOG

	doicon etc/${PN}.png
	domenu etc/${MY_PN}.desktop
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	python_mod_optimize "${GAMES_DATADIR}/${PN}"
}

pkg_postrm() {
	python_mod_cleanup "${GAMES_DATADIR}/${PN}"

	elog "Installed softwares and games with playonlinux have not been removed."
	elog "To remove them, you can re-install playonlinux and remove them using it"
	elog "or do it manually by removing .PlayOnLinux/ in your home directory."
}
