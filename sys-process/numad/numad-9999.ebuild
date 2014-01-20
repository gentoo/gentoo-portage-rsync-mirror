# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/numad/numad-9999.ebuild,v 1.3 2014/01/20 07:50:15 jlec Exp $

EAPI=5

inherit git-r3 linux-info toolchain-funcs

if [[ ${PV} = "9999" ]]; then
	inherit git-2
	EGIT_REPO_URI="git://git.fedorahosted.org/numad.git"
	KEYWORDS=""
else
	SRC_URI=""
	KEYWORDS="~amd64 ~x86 -arm -s390"
fi

DESCRIPTION="The NUMA daemon that manages application locality"
HOMEPAGE="http://fedoraproject.org/wiki/Features/numad"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

CONFIG_CHECK="~NUMA ~CPUSETS"

src_prepare() {
	EPATCH_FORCE=yes EPATCH_SUFFIX="patch" EPATCH_SOURCE="${FILESDIR}" \
		epatch

	tc-export CC
}

src_configure() {
	:
}

src_compile() {
	emake CFLAGS="${CFLAGS} -std=gnu99"
}

src_install() {
	emake prefix="${ED}/usr" install
}
