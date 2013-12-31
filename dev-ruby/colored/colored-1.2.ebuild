# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/colored/colored-1.2.ebuild,v 1.3 2013/12/28 07:43:52 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 ruby20 ruby21 jruby"

RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="Console coloring"
HOMEPAGE="http://github.com/defunkt"
LICENSE="MIT"

KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

each_ruby_prepare() {
	sed -i -e '/[Mm][Gg]/d' Rakefile || die
}
