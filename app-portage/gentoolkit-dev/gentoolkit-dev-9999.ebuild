# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/gentoolkit-dev/gentoolkit-dev-9999.ebuild,v 1.14 2015/03/23 02:25:31 patrick Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} )

PYTHON_REQ_USE="xml"

inherit git-r3 python-r1

DESCRIPTION="Collection of developer scripts for Gentoo"
HOMEPAGE="http://www.gentoo.org/proj/en/portage/tools/index.xml"
SRC_URI=""
EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/gentoolkit.git
	http://git.overlays.gentoo.org/gitroot/proj/gentoolkit.git"
EGIT_BRANCH="gentoolkit-dev"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="test"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

CDEPEND="
	sys-apps/portage[${PYTHON_USEDEP}]
	dev-lang/perl
	sys-apps/diffutils"
DEPEND="${PYTHON_DEPS}
	test? ( ${CDEPEND} )"
RDEPEND="${PYTHON_DEPS}
	${CDEPEND}"

src_test() {
	# echangelog test is not able to run as root
	# the EUID check may not work for everybody
	if [[ ${EUID} -ne 0 ]];
	then
		python_foreach_impl emake test
	else
		ewarn "test skipped, please re-run as non-root if you wish to test ${PN}"
	fi
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	python_replicate_script "${ED}"/usr/bin/{ekeyword,imlate}
}
