# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxnode/nxnode-3.5.0.9.ebuild,v 1.2 2012/07/12 08:49:36 voyageur Exp $

EAPI=4

inherit eutils user versionator

MAJOR_PV="$(get_version_component_range 1-3)"
FULL_PV="${MAJOR_PV}-$(get_version_component_range 4)"
DESCRIPTION="shared components between the different editions of NoMachine's NX Servers"
HOMEPAGE="http://www.nomachine.com/"
SRC_URI="amd64? ( http://64.34.161.181/download/${MAJOR_PV}/Linux/nxnode-${FULL_PV}.x86_64.tar.gz )
	x86? ( http://64.34.161.181/download/${MAJOR_PV}/Linux/nxnode-${FULL_PV}.i386.tar.gz )"

# GPL-2 for Gentoo init script
LICENSE="nomachine GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="rdesktop vnc"
RESTRICT="strip"

DEPEND=""
RDEPEND="=net-misc/nxclient-${MAJOR_PV}*[cups]
	sys-process/lsof
	x11-libs/libICE
	x11-libs/libXmu
	x11-libs/libSM
	x11-libs/libXt
	x11-libs/libXaw
	x11-libs/libXpm
	x11-apps/xrdb
	rdesktop? ( net-misc/rdesktop )
	vnc? ( x11-misc/x11vnc
		   net-misc/tightvnc )"

S=${WORKDIR}/NX

pkg_preinst()
{
	enewuser nx -1 -1 /usr/NX/home/nx
}

src_prepare()
{
	epatch "${FILESDIR}"/nxnode-3.4.0-setup.patch
	epatch "${FILESDIR}"/nxnode-3.4.0-cups_path.patch
}

src_install()
{
	# we install nxnode into /usr/NX, to make sure it doesn't clash
	# with libraries installed for FreeNX

	into /usr/NX
	for x in nxagent nxnode nxsensor nxspool nxuexec ; do
		dobin bin/$x
	done

	dodir /usr/NX/etc
	cp etc/node-debian.cfg.sample "${D}"/usr/NX/etc/node-gentoo.cfg.sample || die
	sed -e 's|COMMAND_FUSER = .*|COMMAND_FUSER = "/usr/bin/fuser"|;' -i "${D}"/usr/NX/etc/node-gentoo.cfg.sample || die
	cp etc/node.lic.sample "${D}"/usr/NX/etc/node.lic.sample || die

	dodir /usr/NX/lib
	cp -R lib "${D}"/usr/NX || die

	dodir /usr/NX/scripts
	cp -R scripts "${D}"/usr/NX || die

	dodir /usr/NX/share
	cp -R share "${D}"/usr/NX || die

	dodir /usr/NX/var
	cp -R var "${D}"/usr/NX || die

	dodir /etc/init.d
	newinitd "${FILESDIR}"/nxnode-3.0.0-init nxsensor
}

pkg_postinst()
{
	# Only install license file if none is found
	if [ ! -f /usr/NX/etc/node.lic ]; then
		cp "${ROOT}"/usr/NX/etc/node.lic.sample "${ROOT}"/usr/NX/etc/node.lic || die
		chmod 0400 "${ROOT}"/usr/NX/etc/node.lic
		chown nx:0 "${ROOT}"/usr/NX/etc/node.lic
	fi

	# only run install on the first time
	if [ -f /usr/NX/etc/node.cfg ]; then
		einfo "Running NoMachine's update script"
		"${ROOT}"/usr/NX/scripts/setup/nxnode --update
	else
		einfo "Running NoMachine's setup script"
		"${ROOT}"/usr/NX/scripts/setup/nxnode --install
	fi

	elog "If you want server statistics, please add nxsensor to your default runlevel"
	elog
	elog "  rc-update add nxsensor default"
	elog
	elog "You will also need to change EnableSensor to 1 in /usr/NX/etc/node.cfg"
}
