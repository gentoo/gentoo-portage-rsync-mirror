# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/getmail/getmail-4.24.0.ebuild,v 1.6 2012/09/30 17:55:08 armin76 Exp $

EAPI="4"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-*"
PYTHON_MODNAME="getmailcore"

inherit distutils

DESCRIPTION="A POP3 mail retriever with reliable Maildir and mbox delivery"
HOMEPAGE="http://pyropus.ca/software/getmail/"
SRC_URI="http://pyropus.ca/software/getmail/old-versions/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 ppc x86 ~ppc-macos ~x86-macos ~x64-solaris"
IUSE=""

src_prepare() {
	sed -i -e "s,'getmail-%s' % __version__,'${PF}'," \
		-e "/docs\/COPYING/d" "${S}"/setup.py || die
	distutils_src_prepare
}
