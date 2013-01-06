# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/coldplug/coldplug-20040920-r1.ebuild,v 1.4 2012/12/11 17:58:55 axs Exp $

inherit eutils

# source maintainers named it hotplug-YYYY_MM_DD instead of hotplug-YYYYMMDD
#MY_P=hotplug-${PV:0:4}_${PV:4:2}_${PV:6:2}
#S=${WORKDIR}/${MY_P}
DESCRIPTION="coldplug init.d program to load modules at bootime"
HOMEPAGE="http://linux-hotplug.sourceforge.net"
#SRC_URI="mirror://kernel/linux/utils/kernel/hotplug/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

# hotplug needs pcimodules utility provided by pcitutils-2.1.9-r1
DEPEND=">=sys-apps/hotplug-20040920"
# conflicts with udev now.
RDEPEND="!virtual/udev
	!>=sys-fs/udev-089"

src_install() {
	newinitd ${FILESDIR}/coldplug.rc coldplug
}
