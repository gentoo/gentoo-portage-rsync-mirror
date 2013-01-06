# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/fastthread/fastthread-1.0.7-r1.ebuild,v 1.14 2012/05/01 18:24:05 armin76 Exp $

EAPI=2

USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_TASK_TEST="test"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG"

inherit ruby-fakegem

DESCRIPTION="Optimized replacement for thread.rb primitives"
HOMEPAGE="http://gemcutter.org/gems/fastthread"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

ruby_add_bdepend "
	>=dev-ruby/echoe-2.7.11
	dev-ruby/rake
	test? ( virtual/ruby-test-unit )"

all_ruby_prepare() {
	sed -i -e 's|if Platform|if Echoe::Platform|' Rakefile || die
}

each_ruby_compile() {
	${RUBY} -S rake compile || die "build failed"
}
