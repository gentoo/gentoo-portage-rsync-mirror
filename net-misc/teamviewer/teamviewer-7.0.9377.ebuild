# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/teamviewer/teamviewer-7.0.9377.ebuild,v 1.5 2014/11/12 23:18:50 axs Exp $

EAPI=5

inherit eutils gnome2-utils

# Major version
MV=${PV/\.*}
MY_PN=${PN}-${MV}
DESCRIPTION="All-In-One Solution for Remote Access and Support over the Internet"
HOMEPAGE="http://www.teamviewer.com"
SRC_URI="http://download.teamviewer.com/download/version_${MV}x/teamviewer_linux.tar.gz -> ${P}.tar.gz"

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

QA_PREBUILT="opt/teamviewer-${MV}/*"

S=${WORKDIR}/teamviewer${MV}

make_winewrapper() {
	cat << EOF > "${T}/${MY_PN}"
#!/bin/sh
exec wine "/opt/${MY_PN}/bin/TeamViewer.exe" "\$@"
EOF
	chmod go+rx "${T}/${MY_PN}"
	exeinto /opt/bin
	doexe "${T}/${MY_PN}"
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-POSIX.patch
}

src_install () {
	if use system-wine ; then
		make_winewrapper
		exeinto /opt/${MY_PN}/bin
		doexe "${S}/.wine/drive_c/Program Files/TeamViewer/Version7/"*
	else
		# install scripts and .reg
		insinto /opt/${MY_PN}/bin
		find ".tvscript" -type f \( \! -name "${PN}.desktop*" -a \! -name "${PN}.png" \) \
			-maxdepth 1 -execdir doins '{}' \;

		# install wine
		insinto /opt/${MY_PN}/wine
		doins -r "${S}"/.wine/*
		dosym /opt/${MY_PN}/bin/${PN} /opt/bin/${MY_PN}

		# fix permissions
		fperms 755 /opt/${MY_PN}/bin/{${PN},wrapper,killteamviewer}
		fperms 755 /opt/${MY_PN}/wine/bin/wine{,-preloader,server}
		fperms 755 "/opt/${MY_PN}/wine/drive_c/Program Files/TeamViewer/Version${MV}"/TeamViewer{,_Desktop}.exe
		find "${D}"/opt/${MY_PN} -type f -name "*.so*" -execdir chmod 755 '{}' \;
	fi

	newicon -s 48 "${S}"/.tvscript/${PN}.png ${MY_PN}.png
	dodoc linux_FAQ_{EN,DE}.txt
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

	elog "Logs are written to:"
	elog "  ~/.teamviewer/7"
}

pkg_postrm() {
	gnome2_icon_cache_update
}
