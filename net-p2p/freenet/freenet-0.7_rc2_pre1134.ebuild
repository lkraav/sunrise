# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1
WRAPPER_DATE=20080330
inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="An encrypted network without censorship"
HOMEPAGE="http://www.freenetproject.org/"
SRC_URI="http://dev.gentooexperimental.org/~tommy/${P}.tar.bz2
	http://dev.gentooexperimental.org/~tommy/wrapper-${WRAPPER_DATE}.conf"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-java/db-je:3.2
	dev-java/fec
	dev-java/java-service-wrapper"
DEPEND=">=dev-java/sun-jdk-1.4
	dev-java/ant
	${CDEPEND}"
RDEPEND="x86? ( >=virtual/jre-1.4 )
	amd64? ( >=virtual/jre-1.5 )
	x86? ( net-p2p/fec )
	net-p2p/nativebiginteger
	${CDEPEND}"
PDEPEND="net-p2p/NativeThread"
S="${WORKDIR}/${PN}"

EANT_BUILD_TARGET="dist"

pkg_setup() {
	enewgroup freenet
	enewuser freenet -1 -1 /opt/freenet freenet
}

src_unpack() {
	unpack "${P}".tar.bz2
	cd "${S}"
	cp "${DISTDIR}"/wrapper-${WRAPPER_DATE}.conf wrapper.conf
	epatch "${FILESDIR}"/wrapper.conf.patch
	epatch "${FILESDIR}"/ext.patch
	use amd64 && sed -i -e 's/=lib/=lib64/g' wrapper.conf
	mkdir -p lib
	cd lib
	java-pkg_jar-from db-je-3.2
	java-pkg_jar-from java-service-wrapper
	java-pkg_jar-from fec
}

src_compile() {
	#workaround for installed blackdown-jdk-1.4
	#freenet does not compile with it
	if has_version =dev-java/sun-jdk-1.4*; then
		GENTOO_VM="sun-jdk-1.4" java-pkg-2_src_compile
	elif has_version =dev-java/sun-jdk-1.5*; then
		GENTOO_VM="sun-jdk-1.5" java-pkg-2_src_compile
	elif has_version =dev-java/sun-jdk-1.6*; then
		GENTOO_VM="sun-jdk-1.6" java-pkg-2_src_compile
	fi
}

src_install() {
	mv lib/freenet-cvs-snapshot.jar freenet.jar
	java-pkg_dojar freenet.jar
	doinitd "${FILESDIR}"/freenet
	dodoc license/README license/LICENSE.Mantissa \
		AUTHORS README
	insinto /opt/freenet
	doins seednodes.fref wrapper.conf run.sh
	dodir /opt/freenet/bin
	dosym /usr/bin/wrapper /opt/freenet/bin/wrapper
	dodir /opt/freenet/$(get_libdir)
	dosym ../../../usr/$(get_libdir)/java-service-wrapper/libwrapper.so /opt/freenet/$(get_libdir)/libwrapper.so
	fperms +x /opt/freenet/run.sh
}

pkg_postinst () {
	elog "1. Start freenet with /etc/init.d/freenet start."
	elog "2. Open localhost:8888 in your browser for the web interface."
	elog
	elog "If you dont know trusted people running freenet,"
	elog "enable opennet (\"insecure mode\") on the config page to get started."
	elog
	if use amd64;then
		if has_version =dev-java/blackdown-jdk-1.4*;then
			elog "Freenet does not run with 64bit blackdown-jdk,"
			elog "please make sure that either system-vm or the"
			elog "user-vm for freenet uses sun-jdk or some other"
			elog "vm (other vms are untested)."
			elog
		fi
	fi
	chown freenet:freenet /opt/freenet
}

pkg_postrm() {
	elog "If you dont want to use freenet any more"
	elog "and dont want to keep your identity/other stuff"
	elog "remember to do 'rm -rf /opt/freenet' to remove everything"
}
