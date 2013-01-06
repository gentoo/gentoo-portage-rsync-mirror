# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xmlformat/xmlformat-1.04.ebuild,v 1.3 2010/08/07 13:23:52 graaff Exp $

DESCRIPTION="Reformat XML documents to your custom style"
SRC_URI="http://www.kitebird.com/software/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.kitebird.com/software/xmlformat/"

SLOT="0"
LICENSE="xmlformat"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"

DEPEND="ruby? ( =dev-lang/ruby-1.8* )
	!ruby? ( dev-lang/perl )"
IUSE="ruby doc"

src_install() {
	dobin xmlformat.pl

	if use ruby
	then
		dobin xmlformat.rb
		dosym xmlformat.rb /usr/bin/xmlformat
	else
		dosym xmlformat.pl /usr/bin/xmlformat
	fi

	dodoc BUGS ChangeLog LICENSE README TODO

	if use doc
	then
		# APIs
		insinto /usr/share/doc/${PF}
		doins -r docs/*
	fi
}

src_test() {
	if use ruby
	then
		./runtest all || die "runtest for ruby failed."
	else
		./runtest -p all || die "runtest for perl failed."
	fi
}
