# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/getmail/getmail-4.40.1.ebuild,v 1.2 2013/09/05 19:44:46 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="A POP3 mail retriever with reliable Maildir and mbox delivery"
HOMEPAGE="http://pyropus.ca/software/getmail/"
SRC_URI="http://pyropus.ca/software/getmail/old-versions/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~ppc ~x86 ~ppc-macos ~x86-macos ~x64-solaris"

python_prepare_all() {
	sed -i -e "s,'getmail-%s' % __version__,'${PF}'," \
		-e "/docs\/COPYING/d" "${S}"/setup.py || die

	distutils-r1_python_prepare_all
}
