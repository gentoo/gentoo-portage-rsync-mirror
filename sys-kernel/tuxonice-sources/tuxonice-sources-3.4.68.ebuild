# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/tuxonice-sources/tuxonice-sources-3.4.68.ebuild,v 1.1 2013/11/10 00:23:52 tomwij Exp $

EAPI="5"
ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="49"

inherit kernel-2 versionator
detect_version
detect_arch

DESCRIPTION="TuxOnIce + Gentoo patchset sources"
HOMEPAGE="http://dev.gentoo.org/~mpagano/genpatches/ http://www.tuxonice.net"

TUXONICE_SNAPSHOT="2013-11-07"
TUXONICE_PV="${PV}"

TUXONICE_PATCH="tuxonice-for-linux-${TUXONICE_PV}-${TUXONICE_SNAPSHOT}.patch.bz2"
TUXONICE_URI="http://tuxonice.net/downloads/all/${TUXONICE_PATCH}"
UNIPATCH_LIST="${DISTDIR}/${TUXONICE_PATCH}"
UNIPATCH_STRICTORDER="yes"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${TUXONICE_URI}"

KEYWORDS="~amd64 ~x86"

RDEPEND="${RDEPEND}
	>=sys-apps/tuxonice-userui-1.0
	|| ( >=sys-power/hibernate-script-2.0 sys-power/pm-utils )"

K_EXTRAELOG="If there are issues with this kernel, please direct any
		queries to the tuxonice-users mailing list:
		http://lists.tuxonice.net/mailman/listinfo/tuxonice-users/"
K_SECURITY_UNSUPPORTED="1"
