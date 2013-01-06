# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/augeas/augeas-0.7.4.ebuild,v 1.2 2011/04/10 12:56:06 klausman Exp $

DESCRIPTION="A library for changing configuration files"
HOMEPAGE="http://augeas.net/"
SRC_URI="http://augeas.net/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="test"

RDEPEND="sys-libs/readline"
DEPEND="${RDEPEND}
	>=app-doc/NaturalDocs-1.40
	test? ( dev-lang/ruby )"

src_compile() {
	if [ -f /usr/share/NaturalDocs/Config/Languages.txt ] ; then
		addwrite /usr/share/NaturalDocs/Config/Languages.txt
	fi
	if [ -f /usr/share/NaturalDocs/Config/Topics.txt ] ; then
		addwrite /usr/share/NaturalDocs/Config/Topics.txt
	fi

	econf || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	dodoc AUTHORS ChangeLog README NEWS
}
