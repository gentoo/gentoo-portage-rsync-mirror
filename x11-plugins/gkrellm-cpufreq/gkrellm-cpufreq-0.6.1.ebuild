# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-cpufreq/gkrellm-cpufreq-0.6.1.ebuild,v 1.4 2007/12/06 17:44:53 opfer Exp $

inherit gkrellm-plugin

MY_P=${P/gkrellm/gkrellm2}

DESCRIPTION="A Gkrellm2 plugin for displaying and manipulating CPU frequency"
HOMEPAGE="http://iacs.epfl.ch/~winkelma/gkrellm2-cpufreq/"
SRC_URI="http://iacs.epfl.ch/~winkelma/gkrellm2-cpufreq//${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S=${WORKDIR}/${MY_P}

RDEPEND="sys-power/cpufrequtils
		app-admin/sudo"

PLUGIN_SO=cpufreq.so

src_install() {
	gkrellm-plugin_src_install
	exeinto /usr/sbin
	doexe cpufreqnextgovernor
}

pkg_postinst() {
	echo
	einfo "Add these lines to /etc/sudoers to allow users to change cpu governor and speed:"
	einfo "ALL ALL = (root) NOPASSWD: /usr/bin/cpufreq-set -c [0-9]* -g userspace"
	einfo "ALL ALL = (root) NOPASSWD: /usr/bin/cpufreq-set -c [0-9]* -f [0-9]*"
	einfo "ALL ALL = (root) NOPASSWD: /usr/sbin/cpufreqnextgovernor"
	echo
}
