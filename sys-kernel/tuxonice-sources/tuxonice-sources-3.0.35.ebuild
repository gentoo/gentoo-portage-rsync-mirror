# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/tuxonice-sources/tuxonice-sources-3.0.35.ebuild,v 1.3 2012/07/24 05:57:57 jdhore Exp $

EAPI="4"

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="26"

inherit kernel-2
detect_version
detect_arch

DESCRIPTION="TuxOnIce + Gentoo patchset sources"
HOMEPAGE="http://dev.gentoo.org/~mpagano/genpatches/ http://www.tuxonice.net"
IUSE=""

TUXONICE_SNAPSHOT="20111012"
TUXONICE_VERSION=""
TUXONICE_TARGET="3.0"

# Because "current" patches can change without notifying, we need to supply them
if [[ -n "${TUXONICE_SNAPSHOT}" ]]; then
	TUXONICE_SRC="http://dev.gentoo.org/~pacho/tuxonice/current-tuxonice-for-${TUXONICE_TARGET}_${TUXONICE_SNAPSHOT}.patch"
	UNIPATCH_LIST="${DISTDIR}/current-tuxonice-for-${TUXONICE_TARGET}_${TUXONICE_SNAPSHOT}.patch.bz2"
else
	TUXONICE_SRC="http://www.tuxonice.net/files/tuxonice-${TUXONICE_VERSION}-for-${TUXONICE_TARGET}.patch"
	UNIPATCH_LIST="${DISTDIR}/tuxonice-${TUXONICE_VERSION}-for-${TUXONICE_TARGET}.patch.bz2"
fi

TUXONICE_URI="${TUXONICE_SRC}.bz2"

UNIPATCH_STRICTORDER="yes"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${TUXONICE_URI}"

KEYWORDS="amd64 x86"

RDEPEND="${RDEPEND}
	>=sys-apps/tuxonice-userui-1.0
	|| ( >=sys-power/hibernate-script-2.0 sys-power/pm-utils )"

K_EXTRAELOG="If there are issues with this kernel, please direct any
queries to the tuxonice-users mailing list:
http://lists.tuxonice.net/mailman/listinfo/tuxonice-users/"
K_SECURITY_UNSUPPORTED="1"
