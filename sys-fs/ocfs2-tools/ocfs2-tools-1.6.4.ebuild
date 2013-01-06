# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ocfs2-tools/ocfs2-tools-1.6.4.ebuild,v 1.4 2012/05/29 12:52:50 xarthisius Exp $

EAPI=3
PYTHON_DEPEND="gtk? 2"
inherit base python versionator

DESCRIPTION="Support programs for the Oracle Cluster Filesystem 2"
HOMEPAGE="http://oss.oracle.com/projects/ocfs2-tools/"
SRC_URI="http://oss.oracle.com/projects/${PN}/dist/files/source/v$(get_version_component_range 1-2)/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug external gtk"

RDEPEND="
	sys-apps/util-linux
	sys-cluster/cman-lib
	external?  (
				|| ( sys-cluster/corosync sys-cluster/openais sys-cluster/dlm-lib )
				)
	sys-fs/e2fsprogs
	sys-libs/ncurses
	sys-libs/readline
	sys-process/psmisc
	gtk? (
		dev-python/pygtk
	)
"
# 99% of deps this thing has is automagic
# specialy cluster things corosync/pacemaker
DEPEND="${RDEPEND}"

DOCS=(
	"${S}/documentation/samples/cluster.conf"
	"${S}/documentation/users_guide.txt"
)

MAKEOPTS+=" -j1"

PATCHES=(
		"${FILESDIR}/${P}-asneeded.patch"
		"${FILESDIR}/${PN}-recent-kernels.patch"
		)

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# gentoo uses /sys/kernel/dlm as dlmfs mountpoint
	sed -e 's:"/dlm/":"/sys/kernel/dlm":g' \
		-i libo2dlm/o2dlm_test.c \
		-i libocfs2/dlm.c || die "sed failed"
}

src_configure() {
	econf \
		$(use_enable debug debug) \
		$(use_enable debug debugexe) \
		$(use_enable gtk ocfs2console) \
		--enable-dynamic-fsck \
		--enable-dynamic-ctl
}

src_install() {
	emake DESTDIR="${D}" install || die
	newinitd "${FILESDIR}/ocfs2.initd" ocfs2 || die
	newconfd "${FILESDIR}/ocfs2.confd" ocfs2 || die
}
