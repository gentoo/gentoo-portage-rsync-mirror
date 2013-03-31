# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/cgi_multipart_eof_fix/cgi_multipart_eof_fix-2.1.ebuild,v 1.9 2013/03/31 17:08:20 tomwij Exp $

EAPI="5"

USE_RUBY="ruby18"
inherit ruby-ng ruby-fakegem

DESCRIPTION="Bug fix CGI multipart parsing when multipart boundary attributes contain non-halting RE."
HOMEPAGE="http://blog.evanweaver.com"
SRC_URI="mirror://rubygems/${P}.gem"
RESTRICT="primaryuri"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-ruby/echoe"
RDEPEND="${DEPEND}"

each_fakegem_test() {
	ruby cgi_multipart_eof_fix_test.rb || die "CGI Multipart EOF fix test failed."
}
