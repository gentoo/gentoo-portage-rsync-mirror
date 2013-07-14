# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/dalli/dalli-2.6.4.ebuild,v 1.1 2013/07/14 07:09:20 graaff Exp $

EAPI=5
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_TEST="test"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.md Performance.md README.md"

inherit ruby-fakegem

DESCRIPTION="A high performance pure Ruby client for accessing memcached servers."
HOMEPAGE="http://github.com/mperham/dalli"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND+="${DEPEND} test? ( >=net-misc/memcached-1.4.0 )"

ruby_add_bdepend "test? (
		dev-ruby/minitest
		>=dev-ruby/mocha-0.13
		=dev-ruby/rails-3* )"

all_ruby_prepare() {
	chmod 0755 "${HOME}" || die "Failed to fix permissions on home"

	sed -i -e '/appraisal/ s:^:#:' Rakefile || die
}
