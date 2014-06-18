# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/teamviewer/teamviewer-8.0.20931.ebuild,v 1.2 2014/06/18 20:40:59 mgorny Exp $

EAPI=5

inherit eutils gnome2-utils systemd unpacker

# Major version
MV=${PV/\.*}
MY_PN=${PN}${MV}
DESCRIPTION="All-In-One Solution for Remote Access and Support over the Internet"
HOMEPAGE="http://www.teamviewer.com"
SRC_URI="http://www.teamviewer.com/download/version_${MV}x/teamviewer_linux.deb -> ${P}.deb"

LICENSE="TeamViewer !system-wine? ( LGPL-2.1 )"
SLOT=${MV}
KEYWORDS="~amd64 ~x86"
IUSE="system-wine"

RESTRICT="mirror"

RDEPEND="
	app-shells/bash
	x11-misc/xdg-utils
	!system-wine? (
		amd64? (
			app-emulation/emul-linux-x86-baselibs
			app-emulation/emul-linux-x86-soundlibs
			|| (
				(
					>=x11-libs/libSM-1.2.1-r1[abi_x86_32]
					>=x11-libs/libX11-1.6.2[abi_x86_32]
					>=x11-libs/libXau-1.0.7-r1[abi_x86_32]
					>=x11-libs/libXdamage-1.1.4-r1[abi_x86_32]
					>=x11-libs/libXext-1.3.2[abi_x86_32]
					>=x11-libs/libXfixes-5.0.1[abi_x86_32]
					>=x11-libs/libXtst-1.2.1-r1[abi_x86_32]
				)
				app-emulation/emul-linux-x86-xlibs
			)
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

QA_PREBUILT="opt/teamviewer${MV}/*"

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
	epatch "${FILESDIR}"/${P}-gentoo.patch

	sed \
		-e "s/@TVV@/${MV}/g" \
		"${FILESDIR}"/${PN}d.init > "${T}"/${PN}d${MV} || die

	sed -i \
		-e "s#/opt/teamviewer8/tv_bin/teamviewerd#/opt/${MY_PN}/teamviewerd#" \
		script/${PN}d.service || die
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

	# necessary symlinks
	dosym ./script/teamviewer /opt/${MY_PN}/TeamViewer
	dosym ./script/teamviewer_desktop /opt/${MY_PN}/TeamViewer_Desktop

	# install daemon binary
	exeinto /opt/${MY_PN}
	doexe ${PN}d

	# set up logdir
	keepdir /var/log/${MY_PN}
	dosym /var/log/${MY_PN} /opt/${MY_PN}/logfiles

	# set up config dir
	keepdir /etc/${MY_PN}
	dosym /etc/${MY_PN} /opt/${MY_PN}/config

	doinitd "${T}"/${PN}d${MV}
	systemd_dounit script/${PN}d.service

	newicon -s 48 desktop/${PN}.png ${MY_PN}.png
	dodoc ../doc/linux_FAQ_{EN,DE}.txt
	make_desktop_entry ${MY_PN} TeamViewer ${MY_PN}
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

	eerror "STARTUP NOTICE:"
	elog "You cannot start the daemon via \"teamviewer --daemon start\"."
	elog "Instead use the provided gentoo initscript:"
	elog "  /etc/init.d/${PN}d${MV} start"
	elog
	elog "Logs are written to \"/var/log/teamviewer8\""

	echo

	eerror "UPDATE NOTICE!"
	ewarn "If you update from teamviewer-8.0.17147"
	ewarn "then you might have to remove \"~/.config/teamviewer8\", because"
	ewarn "the install destination changed and the config might be invalid."
}

pkg_postrm() {
	gnome2_icon_cache_update
}
