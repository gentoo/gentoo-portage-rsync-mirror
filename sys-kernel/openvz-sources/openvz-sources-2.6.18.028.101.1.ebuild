# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/openvz-sources/openvz-sources-2.6.18.028.101.1.ebuild,v 1.3 2013/03/09 21:07:32 tomwij Exp $

EAPI="5"

inherit versionator

ETYPE="sources"

CKV=$(get_version_component_range 1-3)
OKV=${OKV:-${CKV}}
if [[ ${PR} == "r0" ]]; then
KV_FULL=${CKV}-${PN/-*}-$(get_version_component_range 4-6)
else
KV_FULL=${CKV}-${PN/-*}-$(get_version_component_range 4-6)-${PR}
fi
OVZ_KERNEL="$(get_version_component_range 4)stab$(get_version_component_range 5)"
OVZ_REV="$(get_version_component_range 6)"
EXTRAVERSION=-${OVZ_KERNEL}
S=${WORKDIR}/linux-${KV_FULL}

# ${KV_MAJOR}.${KV_MINOR}.${KV_PATCH} should succeed.
KV_MAJOR=$(get_version_component_range 1 ${OKV})
KV_MINOR=$(get_version_component_range 2 ${OKV})
KV_PATCH=$(get_version_component_range 3 ${OKV})

KERNEL_URI="mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/linux-${OKV}.tar.xz"

inherit kernel-2

KEYWORDS="~amd64 ~ppc64 ~sparc ~x86"
IUSE=""
PATCHV="308.8.2.el5"
DESCRIPTION="Full sources including OpenVZ patchset for the 2.6.18 kernel tree"
HOMEPAGE="http://www.openvz.org"
SRC_URI="${KERNEL_URI} ${ARCH_URI}
	http://download.openvz.org/kernel/branches/rhel5-${CKV}/${OVZ_KERNEL}.${OVZ_REV}/patches/patch-${PATCHV}.${OVZ_KERNEL}.${OVZ_REV}-combined.gz"

UNIPATCH_STRICTORDER=1
UNIPATCH_LIST="${DISTDIR}/patch-${PATCHV}.${OVZ_KERNEL}.${OVZ_REV}-combined.gz
${FILESDIR}/${PN}-2.6.18.028.064.7-bridgemac.patch"

K_EXTRAEINFO="This openvz kernel uses RHEL5 patchset instead of vanilla kernel.
This patchset considered to be more stable and security supported by upstream,
that why they suggested us to use it. But note: RHEL5 patchset is very fragile
and fails to build in many configurations so if you have problems use config
files from openvz team http://wiki.openvz.org/Download/kernel/rhel5/${OVZ_KERNEL}.${OVZ_REV}"

K_EXTRAEWARN="This kernel is stable only when built with gcc-4.1.x and is known
to oops in random places if built with newer compilers."
