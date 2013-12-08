# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/tuxonice-sources/tuxonice-sources-3.12.3.ebuild,v 1.1 2013/12/08 16:06:30 floppym Exp $

EAPI="5"
ETYPE="sources"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="4"

inherit kernel-2
detect_version
detect_arch

DESCRIPTION="TuxOnIce + Gentoo patchset sources"
HOMEPAGE="http://dev.gentoo.org/~mpagano/genpatches/ http://www.tuxonice.net"

TUXONICE_SNAPSHOT="2013-12-05"

TUXONICE_PATCH="tuxonice-for-linux-${PV}-${TUXONICE_SNAPSHOT}.patch.bz2"
TUXONICE_URI="http://tuxonice.net/downloads/all/${TUXONICE_PATCH}"
UNIPATCH_LIST="${DISTDIR}/${TUXONICE_PATCH}"
UNIPATCH_STRICTORDER="yes"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${TUXONICE_URI}"

KEYWORDS="~amd64 ~x86"
IUSE="experimental"

RDEPEND="${RDEPEND}
	>=sys-apps/tuxonice-userui-1.0
	|| ( >=sys-power/hibernate-script-2.0 sys-power/pm-utils )"

K_EXTRAELOG="If there are issues with this kernel, please direct any
		queries to the tuxonice-users mailing list:
		http://lists.tuxonice.net/mailman/listinfo/tuxonice-users/"
K_SECURITY_UNSUPPORTED="1"
