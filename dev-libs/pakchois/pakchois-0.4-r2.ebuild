# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pakchois/pakchois-0.4-r2.ebuild,v 1.7 2014/10/27 16:03:59 ago Exp $

EAPI="5"

inherit multilib-minimal

DESCRIPTION="PaKChoiS - PKCS #11 wrapper library"
HOMEPAGE="http://www.manyfish.co.uk/pakchois/"
SRC_URI="http://www.manyfish.co.uk/pakchois/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86"
IUSE="nls"

DEPEND=""
RDEPEND=""

multilib_src_configure() {
	ECONF_SOURCE=${S} \
	econf \
		$(use_enable nls)
}
