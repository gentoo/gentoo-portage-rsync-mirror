# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/eio/eio-1.7.6.ebuild,v 1.1 2013/04/10 21:32:41 tommy Exp $

EAPI=2

inherit enlightenment

DESCRIPTION="Enlightenment's integration to IO"
HOMEPAGE="http://trac.enlightenment.org/e/wiki/EIO"

SRC_URI="http://download.enlightenment.org/releases/${P}.tar.bz2"
LICENSE="LGPL-2"

KEYWORDS="~amd64 ~x86"
IUSE="examples static-libs"

RDEPEND=">=dev-libs/ecore-1.7.6
	>=dev-libs/eet-1.7.6"
DEPEND="${RDEPEND}"

#src_prepare() {
#	sed -i "s:1.7.5:1.7.4:g" configure.ac
#	eautoreconf
#}

src_configure() {
	MY_ECONF="--enable-posix-threads
		$(use_enable doc)
		$(use_enable examples build-examples)
		$(use_enable examples install-examples)"
	enlightenment_src_configure
}
