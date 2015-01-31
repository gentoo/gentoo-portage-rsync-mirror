# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/s3cmd/s3cmd-1.5.0_rc1.ebuild,v 1.2 2015/01/31 16:57:08 darkside Exp $

EAPI="3"
PYTHON_DEPEND="2"
PYTHON_USE_WITH="xml"

inherit distutils

KEYWORDS="~amd64 ~x86 ~x64-macos"
DESCRIPTION="Command line client for Amazon S3"
HOMEPAGE="http://s3tools.org/s3cmd"
SRC_URI="mirror://sourceforge/s3tools/${P/_/-}.tar.gz"
LICENSE="GPL-2"

IUSE=""
SLOT="0"

DEPEND=""
RDEPEND=""

PYTHON_MODNAME="S3"

S=$WORKDIR/${P/_/-}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	S3CMD_INSTPATH_DOC="${EPREFIX}"/usr/share/doc/${PF} distutils_src_install
	rm -rf "${ED}"/usr/share/doc/${PF}/${PN} || die 'rm failed'
}
