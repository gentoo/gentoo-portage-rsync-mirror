# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios-check_openvpn-simple/nagios-check_openvpn-simple-0.0.1.ebuild,v 1.2 2014/07/06 12:53:45 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} )
inherit distutils-r1 multilib

MY_PN="${PN/nagios-/}"
MY_P="${P/nagios-/}"
DESCRIPTION="A Nagios plugin to check whether an OpenVPN server is alive"
HOMEPAGE="http://michael.orlitzky.com/code/${MY_PN}.php"
SRC_URI="http://michael.orlitzky.com/code/releases/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	distutils-r1_src_install

	local nagiosplugindir="/usr/$(get_libdir)/nagios/plugins"
	dodir "${nagiosplugindir}"

	# Create a symlink from the nagios plugin directory to the /usr/bin
	# location. The "binary" in /usr/bin should also be a symlink, since
	# the python machinery allows the user to switch out the
	# interpreter. We don't want to mess with any of that, so we just
	# point to whatever the system would use if the user executed
	# ${MY_PN}.
	#
	# The relative symlink is preferred so that if the package is
	# installed e.g. while in a chroot, the symlink will never point
	# outside of that chroot.
	#
	dosym "../../../bin/${MY_PN}" "${nagiosplugindir}/${MY_PN}"
}
