# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/s3cmd/s3cmd-1.5.2.ebuild,v 1.1 2015/03/10 16:18:14 monsieurp Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="xml"

inherit distutils-r1

KEYWORDS="~amd64 ~x86 ~x64-macos"
DESCRIPTION="Command line client for Amazon S3"
HOMEPAGE="http://s3tools.org/s3cmd"
SRC_URI="mirror://sourceforge/s3tools/${P/_/-}.tar.gz"
LICENSE="GPL-2"

IUSE=""
SLOT="0"

DEPEND="${PYTHON_DEPS}"
RDEPEND=""

S=$WORKDIR/${P/_/-}

src_install() {
	S3CMD_INSTPATH_DOC="${EPREFIX}"/usr/share/doc/${PF} distutils-r1_src_install
	rm -rf "${ED}"/usr/share/doc/${PF}/${PN} || die 'rm failed'
}
