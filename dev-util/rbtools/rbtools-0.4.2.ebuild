# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/rbtools/rbtools-0.4.2.ebuild,v 1.3 2013/01/01 00:01:44 jdhore Exp $

EAPI=4
PYTHON_DEPEND=2

inherit versionator distutils

MY_PN=RBTools
MY_P=${MY_PN}-${PV}

DESCRIPTION="Command line tools for use with Review Board"
HOMEPAGE="http://www.reviewboard.org/"
SRC_URI="http://downloads.reviewboard.org/releases/${MY_PN}/$(get_version_component_range 1-2)/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

DOCS=(AUTHORS NEWS README)

S=${WORKDIR}/${MY_P}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}
