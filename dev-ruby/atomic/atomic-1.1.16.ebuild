# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/atomic/atomic-1.1.16.ebuild,v 1.1 2014/03/22 07:03:43 graaff Exp $

EAPI=5
# jruby → there is code for this in ext but that requires compiling java.
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_TASK_DOC=""

inherit multilib ruby-fakegem

DESCRIPTION="An atomic reference implementation for JRuby, Rubinius, and MRI"
HOMEPAGE="https://github.com/headius/ruby-atomic"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~x86"
IUSE=""

all_ruby_prepare() {
	# Avoid compilation dependencies since we compile directly.
	sed -i -e '/:test => :compile/ s:^:#:' Rakefile || die
}

each_ruby_configure() {
	${RUBY} -Cext extconf.rb || die
}

each_ruby_compile() {
	emake V=1 -Cext
	cp ext/atomic_reference$(get_modname) lib/ || die
}
