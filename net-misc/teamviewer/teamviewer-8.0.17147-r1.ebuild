# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/teamviewer/teamviewer-8.0.17147-r1.ebuild,v 1.2 2013/03/23 19:55:59 vapier Exp $

EAPI=5

inherit eutils gnome2-utils systemd unpacker

# Major version
MV=${PV/\.*}
MY_PN=${PN}-${MV}
DESCRIPTION="All-In-One Solution for Remote Access and Support over the Internet"
HOMEPAGE="http://www.teamviewer.com"
SRC_URI="http://www.teamviewer.com/download/version_${MV}x/teamviewer_linux.deb -> ${P}.deb"

LICENSE="TeamViewer !system-wine? ( LGPL-2.1 )"
SLOT=${MV}
KEYWORDS="~amd64 ~x86"
IUSE="system-wine"

RESTRICT="mirror"

RDEPEND="
	x11-misc/xdg-utils
	!system-wine? (
		amd64? (
			app-emulation/emul-linux-x86-baselibs
			app-emulation/emul-linux-x86-soundlibs
			app-emulation/emul-linux-x86-xlibs
		)
		x86? (
			sys-libs/zlib
			x11-libs/libSM
			x11-libs/libX11
			x11-libs/libXau
			x11-libs/libXdamage
			x11-libs/libXext
			x11-libs/libXfixes
			x11-libs/libXtst
		)
	)
	system-wine? ( app-emulation/wine )"

QA_PREBUILT="opt/teamviewer-${MV}/*"

S=${WORKDIR}/opt/teamviewer${MV}/tv_bin

make_winewrapper() {
	cat << EOF > "${T}/${MY_PN}"
#!/bin/sh
export WINEDLLPATH=/opt/${MY_PN}
exec wine "/opt/${MY_PN}/TeamViewer.exe" "\$@"
EOF
	chmod go+rx "${T}/${MY_PN}"
	exeinto /opt/bin
	doexe "${T}/${MY_PN}"
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-POSIX.patch \
		"${FILESDIR}"/${P}-gentoo.patch

	sed \
		-e "s/@TVV@/${MV}/g" \
		"${FILESDIR}"/${PN}d.init > "${T}"/${PN}d-${MV} || die
}

src_install () {
	if use system-wine ; then
		make_winewrapper
		exeinto /opt/${MY_PN}
		doexe wine/drive_c/TeamViewer/*
	else
		# install scripts and .reg
		insinto /opt/${MY_PN}/script
		doins script/*.reg
		exeinto /opt/${MY_PN}/script
		doexe script/teamviewer{,_desktop} script/tvw_{aux,config,main,profile}

		# install internal wine
		insinto /opt/${MY_PN}
		doins -r wine
		dosym /opt/${MY_PN}/script/${PN} /opt/bin/${MY_PN}

		# fix permissions
		fperms 755 /opt/${MY_PN}/wine/bin/wine{,-preloader,server}
		fperms 755 /opt/${MY_PN}/wine/drive_c/TeamViewer/TeamViewer{,_Desktop}.exe
		find "${D}"/opt/${MY_PN} -type f -name "*.so*" -execdir chmod 755 '{}' \;
	fi

	# install daemon binary
	exeinto /opt/${MY_PN}
	doexe ${PN}d

	doinitd "${T}"/${PN}d-${MV}
	systemd_dounit "${FILESDIR}"/${PN}.service

	newicon -s 48 desktop/${PN}.png ${MY_PN}.png
	dodoc ../linux_FAQ_{EN,DE}.txt
	make_desktop_entry ${MY_PN} TeamViewer-${MV} ${MY_PN}
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update

	if use system-wine ; then
		echo
		eerror "IMPORTANT NOTICE!"
		elog "Using ${PN} with system wine is not supported and experimental."
		elog "Do not report gentoo bugs while using this version."
		echo
	fi

	ewarn "STARTUP NOTICE:"
	elog "You cannot start the daemon via \"teamviewer --daemon start\"."
	elog "Instead use the provided gentoo initscript:"
	elog "  /etc/init.d/${PN}d-${MV} start"
	elog
	elog "Logs are written to \"~/.config/teamviewer8/logfiles\""
}

pkg_postrm() {
	gnome2_icon_cache_update
}
