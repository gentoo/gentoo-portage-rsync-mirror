# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/net-dns/net-dns-0.8.0.ebuild,v 1.2 2014/04/24 16:54:40 mrueg Exp $

EAPI=5

USE_RUBY="ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC="yardoc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md THANKS.rdoc"

inherit ruby-fakegem

DESCRIPTION="DNS resolver in pure Ruby"
HOMEPAGE="http://net-dns.rubyforge.org/"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

ruby_add_bdepend "doc? ( dev-ruby/yard )"

all_ruby_prepare() {
	sed -i -e '/bundler/d' Rakefile || die

	sed -i -e '/git ls-files/d' Rakefile || die
}

each_ruby_prepare() {
	case ${RUBY} in
		*jruby)
			# Avoid failing test due to a jruby bug
			# https://github.com/jruby/jruby/issues/310
			sed -i -e '67 s:^:#:' test/rr/aaaa_test.rb || die
			;;
		*)
			;;
	esac
}

all_ruby_install() {
	all_fakegem_install

	docinto examples
	dodoc demo/* || die
}
