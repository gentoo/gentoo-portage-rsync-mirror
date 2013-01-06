# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mdds/mdds-0.6.1.ebuild,v 1.3 2012/12/08 12:26:12 maekke Exp $

EAPI=4

inherit base

DESCRIPTION="A collection of multi-dimensional data structure and indexing algorithm"
HOMEPAGE="http://code.google.com/p/multidimalgorithm/"
SRC_URI="http://multidimalgorithm.googlecode.com/files/${P/-/_}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="dev-libs/boost"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P/-/_}

src_configure() {
	econf \
		--with-hash-container=boost \
		--docdir="${EPREFIX}/usr/share/doc/${PF}"
}

src_compile() { :; }
