# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/tuxonice-sources/tuxonice-sources-3.4.11.ebuild,v 1.1 2012/09/22 09:46:07 pacho Exp $

EAPI="4"

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="12"

inherit kernel-2
detect_version
detect_arch

DESCRIPTION="TuxOnIce + Gentoo patchset sources"
HOMEPAGE="http://dev.gentoo.org/~mpagano/genpatches/ http://www.tuxonice.net"
IUSE=""

TUXONICE_SNAPSHOT="20120721"
TUXONICE_VERSION=""
TUXONICE_TARGET="3.4"
TUXONICE_URI="http://dev.gentoo.org/~pacho/tuxonice/${TUXONICE_SNAPSHOT}-TuxOnIce-for-Linux-${TUXONICE_TARGET}.patch.bz2"

UNIPATCH_LIST="${DISTDIR}/${TUXONICE_SNAPSHOT}-TuxOnIce-for-Linux-${TUXONICE_TARGET}.patch.bz2"
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
