# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ack/ack-1.96.ebuild,v 1.4 2013/01/21 20:08:50 steev Exp $

EAPI=3

ACK_PATCH="ack-gentoo-r1.patch"

MODULE_AUTHOR=PETDANCE
inherit perl-module bash-completion-r1

DESCRIPTION="ack is a tool like grep, aimed at programmers with large trees of heterogeneous source code"
HOMEPAGE="http://betterthangrep.com/ ${HOMEPAGE}"
SRC_URI+=" http://dev.gentoo.org/~tove/distfiles/${CATEGORY}/${PN}/${ACK_PATCH}.bz2"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="amd64 ~arm x86 ~x86-interix ~amd64-linux ~x86-linux ~x86-macos"
IUSE="bash-completion"

DEPEND=">=dev-perl/File-Next-1.02"
RDEPEND="${DEPEND}"

SRC_TEST=do
PATCHES=( "${WORKDIR}"/${ACK_PATCH} )

src_install() {
	perl-module_src_install
	newbashcomp etc/ack.bash_completion.sh ack
}
