# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/swiftiply/swiftiply-0.6.1.1-r1.ebuild,v 1.1 2013/03/31 17:11:45 tomwij Exp $

EAPI="5"

USE_RUBY="ruby18"
inherit ruby-ng ruby-fakegem

MY_COMPANY="swiftcore"
DESCRIPTION="A clustering proxy server for web applications."
HOMEPAGE="http://${PN}.${MY_COMPANY}.org/"
SRC_URI="http://${PN}.${MY_COMPANY}.org/files/${P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-ruby/cgi_multipart_eof_fix
	>=dev-ruby/eventmachine-0.9.0
	www-servers/mongrel"

RUBY_FAKEGEM_EXTRAINSTALL="src"
RUBY_PATCHES=( "${FILESDIR}"/swiftiply-0.6.1.1-ffr-stderror.patch )

QA_PRESTRIPPED="usr/lib/fastfilereaderext.so
	usr/lib32/fastfilereaderext.so
	usr/lib64/fastfilereaderext.so"

all_ruby_compile() {
	sed -i '/build_ext/q' setup.rb || die 'Rewrite of extension build script failed.'
	echo '}' >> setup.rb || die 'Rewrite of extension build script failed.'

	ruby setup.rb
}

all_ruby_install() {
	all_fakegem_install

	# Conflict with www-servers/mongrel.
	rm "${ED}"/usr/bin/mongrel_rails

	dolib ext/fastfilereader/fastfilereaderext.so
}

# There is no rakefile, don't test.
src_test() {
	:
}
