# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/polyglot/polyglot-0.3.3-r1.ebuild,v 1.1 2013/11/11 15:35:15 mrueg Exp $

EAPI=5
USE_RUBY="ruby18 ruby19 ruby20 jruby rbx"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="History.txt README.txt"

inherit ruby-fakegem

DESCRIPTION="Polyglot provides support for fully-custom DSLs."
HOMEPAGE="http://polyglot.rubyforge.org/"
LICENSE="MIT"

KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
SLOT="0"
IUSE=""

all_ruby_prepare() {
	# jruby has trouble parsing this metadata and there are no dependencies.
	rm ../metadata || die
}
