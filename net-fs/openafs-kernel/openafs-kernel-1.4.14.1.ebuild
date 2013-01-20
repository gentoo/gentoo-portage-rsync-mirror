# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/openafs-kernel/openafs-kernel-1.4.14.1.ebuild,v 1.3 2013/01/20 21:47:36 ulm Exp $

EAPI="2"

inherit eutils autotools linux-mod versionator toolchain-funcs linux-info

KV_max=2.6.38
MY_PN=${PN/-kernel}
MY_P=${MY_PN}-${PV}
MY_PV=$(get_version_component_range 1-4)
PVER="1"
DESCRIPTION="The OpenAFS distributed file system kernel module"
HOMEPAGE="http://www.openafs.org/"
SRC_URI="http://openafs.org/dl/${MY_PV}/${MY_P}-src.tar.bz2
	mirror://gentoo/${MY_P}-patches-${PVER}.tar.bz2"

LICENSE="IBM BSD openafs-krb5-a APSL-2"
SLOT="0"
KEYWORDS="amd64 sparc x86"
IUSE=""

S=${WORKDIR}/${MY_P}

CONFIG_CHECK="!DEBUG_RODATA ~!AFS_FS KEYS"
ERROR_DEBUG_RODATA="OpenAFS is incompatible with linux' CONFIG_DEBUG_RODATA option"
ERROR_AFS_FS="OpenAFS conflicts with the in-kernel AFS-support.  Make sure not to load both at the same time!"

pkg_setup() {
	if kernel_is -gt ${KV_max//./ }
	then
	  eerror "${P} does not support Linux kernel version ${KV_max} or higher"
	  die
	fi
	linux-mod_pkg_setup
}

src_prepare() {
	EPATCH_EXCLUDE="012_all_kbuild.patch" \
	EPATCH_SUFFIX="patch" \
	epatch "${WORKDIR}"/gentoo/patches

	# packaging is f-ed up, so we can't run automake (i.e. eautoreconf)
	sed -i '/^a/s:^:e:' regen.sh
	skipman=1
	. regen.sh
}

src_configure() {
	ARCH="$(tc-arch-kernel)" \
	econf \
		--with-linux-kernel-headers=${KV_DIR} \
		--with-linux-kernel-build=${KV_OUT_DIR}
}

src_compile() {
	ARCH="$(tc-arch-kernel)" emake -j1 only_libafs || die
}

src_install() {
	MOD_SRCDIR=$(expr "${S}"/src/libafs/MODLOAD-*)
	[ -f "${MOD_SRCDIR}"/libafs.${KV_OBJ} ] || die "Couldn't find compiled kernel module"

	MODULE_NAMES='libafs(fs/openafs:$MOD_SRCDIR)'

	linux-mod_src_install
}
