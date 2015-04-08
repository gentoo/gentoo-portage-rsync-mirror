# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/memcache-client/memcache-client-1.8.5-r1.ebuild,v 1.5 2014/11/03 15:42:32 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_TASK_TEST="none"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="FAQ.rdoc History.rdoc README.rdoc"

inherit ruby-fakegem

DESCRIPTION="A ruby library for accessing memcached"
HOMEPAGE="http://github.com/mperham/memcache-client"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/flexmock )"

all_ruby_prepare() {
	# Remove tests that require a running memcache deamon.
	rm test/test_benchmark.rb || die "Unable to remove performance tests."

	# Fix silly JRuby test issue:
	# https://github.com/mperham/memcache-client/issues/issue/14
	sed -i -e '558s/e.message/e.message.downcase/' test/test_mem_cache.rb || die die "Could not fix JRuby issue."

	# Fix rake deprecation.
	sed -i -e 's:rake/rdoctask:rdoc/task:' Rakefile || die
}

each_ruby_test() {
	${RUBY} -Ilib -r test/unit test/test_mem_cache.rb || die "Tests failed."
}
